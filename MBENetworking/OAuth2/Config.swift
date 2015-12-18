//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
Configuration object to setup an OAuth2 module
*/
public class Config {
    /**
    Applies the baseURL to the configuration.
    */
    public let baseURL: String
    
    /**
    Applies the "callback URL" once request token issued.
    */
    public let redirectURL: String

    /**
    Applies the "authorization endpoint" to the request token.
    */
    public var authzEndpoint: String
    
    /**
    Applies the "access token endpoint" to the exchange code for access token.
    */
    public var accessTokenEndpoint: String

    /**
    Endpoint for request to invalidate both accessToken and refreshToken.
    */
    public let revokeTokenEndpoint: String?
    
    /**
    Endpoint for request a refreshToken.
    */
    public let refreshTokenEndpoint: String?
    
    /**
    Endpoint for OpenID Connect to get user information.
    */
    public let userInfoEndpoint: String?
    
    /**
    Boolean to indicate whether OpenID Connect on authorization code grant flow is used.
    */
    public var isOpenIDConnect: Bool
    
    /**
    Applies the various scopes of the authorization.
    */
    public var scopes: [String]
    
    var scope: String {
        get {
            // Create a string to concatenate all scopes existing in the _scopes array.
            var scopeString = ""
            for scope in self.scopes {
                scopeString += scope.urlEncode()
                // If the current scope is other than the last one, then add the "+" sign to the string to separate the scopes.
                if (scope != self.scopes.last) {
                    scopeString += "+"
                }
            }
            return scopeString
        }
    }
    
    /**
    Applies the "client id" obtained with the client registration process.
    */
    public let clientId: String
    
    /**
    Applies the "client secret" obtained with the client registration process.
    */
    public let clientSecret: String?
    
    /**
    Account id is used with AccountManager to store tokens. AccountId is defined by the end-user
    and can be any String. If AccountManager is not used, this field is optional.
    */
    public var accountId: String?
    
    /**
    Boolean to indicate to either used a webview (if true) or an external browser (by default, false)
    for authorization code grant flow.
    */
    public var isWebView: Bool = false
    
    public init(base: String, authzEndpoint: String, redirectURL: String, accessTokenEndpoint: String, clientId: String, refreshTokenEndpoint: String? = nil, revokeTokenEndpoint: String? = nil, isOpenIDConnect:Bool = false, userInfoEndpoint: String? = nil, scopes: [String] = [],  clientSecret: String? = nil, accountId: String? = nil, isWebView: Bool = false) {
        self.baseURL = base
        self.authzEndpoint = authzEndpoint
        self.redirectURL = redirectURL
        self.accessTokenEndpoint = accessTokenEndpoint
        self.refreshTokenEndpoint = refreshTokenEndpoint
        self.revokeTokenEndpoint = revokeTokenEndpoint
        self.isOpenIDConnect = isOpenIDConnect ?? false
        self.userInfoEndpoint = userInfoEndpoint
        self.scopes = scopes
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.accountId = accountId
        self.isWebView = isWebView
    }
}