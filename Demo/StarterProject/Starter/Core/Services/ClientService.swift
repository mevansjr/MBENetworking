//
//  ClientService.swift
//  Starter
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

public class ClientService: NSObject {
    
    // MARK: Properties
    
    var http: Http!
    var protectionSpace: NSURLProtectionSpace?
    var credential: NSURLCredential?
    var credentialStorage: NSURLCredentialStorage?
    var version: String = "/\(Global.API_VERSION)"
    var loggedIn = false
    
    // MARK: Shared Instance
    
    class var sharedInstance: ClientService {
        struct Static {
            static var instance: ClientService?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ClientService()
            Static.instance!.setupHTTP()
        }
        
        return Static.instance!
    }
    
    // MARK: Setup Methods
    
    func setupHTTP() {
        
        if self.validateToken() {
            self.loggedIn = true
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        if self.credentialStorage != nil {
            configuration.URLCredentialStorage = self.credentialStorage!
        }
        
        self.http = Http(baseURL: Global.API_BASE_DOMAIN, sessionConfig: configuration)
    }
    
    func saveUserCredientials(credential: NSURLCredential?, oauth: OAuth) {
        if credential != nil {
            self.protectionSpace = NSURLProtectionSpace(host: Global.API_BASE_DOMAIN, port: 443, `protocol`: NSURLProtectionSpaceHTTPS, realm: nil, authenticationMethod: NSURLAuthenticationMethodHTTPDigest)
            self.credentialStorage = NSURLCredentialStorage.sharedCredentialStorage()
            self.credentialStorage!.setDefaultCredential(credential!, forProtectionSpace: self.protectionSpace!)
        }
        if oauth.access_token != nil {
            NSUserDefaults.standardUserDefaults().setObject("Bearer \(oauth.access_token!)", forKey: Global.API_ACCESS_TOKEN)
        }
        if oauth.refresh_token != nil {
            NSUserDefaults.standardUserDefaults().setObject(oauth.refresh_token!, forKey: Global.API_REFRESH_TOKEN)
        }
        if oauth.expires_in != nil {
            let ti: NSTimeInterval = NSTimeInterval(oauth.expires_in!)
            let expireDate = NSDate().dateByAddingTimeInterval(ti)
            NSUserDefaults.standardUserDefaults().setObject(expireDate, forKey: Global.API_TOKEN_EXPIRE_DATE)
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.setupHTTP()
    }
    
    func validateToken() -> Bool {
        if let expTokenDate = NSUserDefaults.standardUserDefaults().valueForKey(Global.API_TOKEN_EXPIRE_DATE) as? NSDate {
            let nowTI = NSDate().timeIntervalSince1970
            let expTI = expTokenDate.timeIntervalSince1970
            let adjExpTI = expTI - (60*5)
            if adjExpTI > nowTI {
                return true
            }
        }
        return false
    }
    
    // MARK: Refresh Application Delegate Methods
    
    func onStart() {
        if let refreshToken = NSUserDefaults.standardUserDefaults().valueForKey(Global.API_REFRESH_TOKEN) as? String {
            ClientService.sharedInstance.refreshToken(refreshToken, completion: { (success) -> () in
                if success != nil {
                    self.loggedIn = true
                }
            })
        }
    }
    
    func onTerminate() {
        if let refreshToken = NSUserDefaults.standardUserDefaults().valueForKey(Global.API_REFRESH_TOKEN) as? String {
            ClientService.sharedInstance.refreshToken(refreshToken, completion: { (success) -> () in
                if success != nil {
                    self.loggedIn = true
                }
            })
        }
    }
    
    // MARK: Error Handling Methods
    
    func handleError(error: NSError) {
       var message = ""
        var code = error.code
        if error.userInfo[NetworkingOperationFailingURLResponseErrorKey] != nil {
            if let urlresponse: NSHTTPURLResponse = error.userInfo[NetworkingOperationFailingURLResponseErrorKey] as! NSHTTPURLResponse! {
                let headers = urlresponse.allHeaderFields
                if headers["Message"] != nil {
                    message = headers["Message"]! as! String
                }
                code = urlresponse.statusCode
            }
        }
        print("Error Code: \(code)")
        if code == 401 {
            self.loggedIn = false
        }
        if message.characters.count > 0 {
            print("Error Message: \(message)")
        }
        else {
            print("Error: \(error)")
        }
    }
    
    // MARK: OAuth Methods
    
    func loginUser(username: String, password: String, completion: (success: OAuth?) -> ()) {
        
        let params = ["grant_type": "password",
            "client_id": Global.API_CLIENT_ID,
            "client_secret": Global.API_CLIENT_SECRET,
            "username": username,
            "password": password
        ]
        
        self.http.LOGIN("/oauth/token", parameters: params, credential: self.credential) { (success, error) -> Void in
            
            var oauthUser: OAuth?
            if success != nil {
                if let c = success! as? NSDictionary {
                    oauthUser = Mapper().map(c)
                    self.loggedIn = true
                    self.credential = NSURLCredential(user: username,
                        password: password,
                        persistence: .ForSession)
                    self.saveUserCredientials(self.credential, oauth: oauthUser!)
                }
            }
            else if error != nil {
                self.handleError(error!)
            }
            completion(success: oauthUser)
        }
    }
    
    func refreshToken(refreshToken: String, completion: (success: OAuth?) -> ()) {
        
        let params = ["grant_type": "refresh_token",
            "client_id": Global.API_CLIENT_ID,
            "client_secret": Global.API_CLIENT_SECRET,
            "refresh_token": refreshToken
        ]
        
        self.http.LOGIN("/oauth/token", parameters: params, credential: self.credential) { (success, error) -> Void in
            
            var oauthUser: OAuth?
            if success != nil {
                if let c = success! as? NSDictionary {
                    oauthUser = Mapper().map(c)
                    self.saveUserCredientials(self.credential, oauth: oauthUser!)
                }
            }
            else if error != nil {
                self.handleError(error!)
            }
            completion(success: oauthUser)
        }
    }
    
    func logoutUser() {
        self.loggedIn = false
        if self.credential != nil && self.credentialStorage != nil && self.protectionSpace != nil {
            self.credentialStorage!.removeCredential(self.credential!, forProtectionSpace: self.protectionSpace!)
        }
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
        NSUserDefaults.standardUserDefaults().synchronize()
        self.setupHTTP()
    }
    
     // MARK: Client Methods
    
    func getUser(completion: (success: User?) -> ()) {
        self.http.GET(version.stringByAppendingString("/user")) { (success, error) -> Void in
            var user: User?
            if success != nil {
                if let c = success! as? NSDictionary {
                    user = Mapper().map(c)
                }
            }
            else if error != nil {
                self.handleError(error!)
            }
            completion(success: user)
        }
    }
}