//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}

/**
An OAuth2Session implementation the stores OAuth2 metadata in-memory
*/
public class UntrustedMemoryOAuth2Session: OAuth2Session {
    
    /**
    The account id.
    */
    public var accountId: String
    
    /**
    The access token which expires.
    */
    public var accessToken: String?
    
    /**
    The access token's expiration date.
    */
    public var accessTokenExpirationDate: NSDate?
    
    /**
    The refresh tokens. This toke does not expire and should be used to renew access token when expired.
    */
    public var refreshToken: String?
    
    /**
    The refresh token's expiration date.
    */
    public var refreshTokenExpirationDate: NSDate?
    
    /**
    Check validity of accessToken. return true if still valid, false when expired.
    */
    public func tokenIsNotExpired() -> Bool {
        return self.accessTokenExpirationDate != nil ? (self.accessTokenExpirationDate!.timeIntervalSinceDate(NSDate()) > 0) : true
    }
    
    /**
    Check validity of refreshToken. return true if still valid, false when expired.
    */
    public func refreshTokenIsNotExpired() -> Bool {
        return self.refreshTokenExpirationDate != nil ? (self.refreshTokenExpirationDate!.timeIntervalSinceDate(NSDate()) > 0) : true
    }
    
    /**
    Save in memory tokens information. Saving tokens allow you to refresh accesstoken transparently for the user without prompting for grant access.
    */
    public func saveAccessToken(accessToken: String?, refreshToken: String?, accessTokenExpiration: String?, refreshTokenExpiration: String?) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        let now = NSDate()
        if let inter = accessTokenExpiration?.doubleValue {
            self.accessTokenExpirationDate = now.dateByAddingTimeInterval(inter)
        }
        if let interRefresh = refreshTokenExpiration?.doubleValue {
            self.refreshTokenExpirationDate = now.dateByAddingTimeInterval(interRefresh)
        }
    }
    
    /**
    Clear all tokens. Method used when doing logout or revoke.
    */
    public func clearTokens() {
        self.accessToken = nil
        self.refreshToken = nil
        self.accessTokenExpirationDate = nil
        self.refreshTokenExpirationDate = nil
    }
    
    /**
    Initialize session using account id. 
    
    :param: accountId uniqueId to identify the oauth2module.
    :param: accessToken optional parameter to initilaize the storage with initial values.
    :param: accessTokenExpirationDate optional parameter to initilaize the storage with initial values.
    :param: refreshToken optional parameter to initilaize the storage with initial values.
    :param: refreshTokenExpirationDate optional parameter to initilaize the storage with initial values.
    */
    public init(accountId: String, accessToken: String? = nil, accessTokenExpirationDate: NSDate? = nil, refreshToken: String? = nil, refreshTokenExpirationDate: NSDate? = nil) {
        self.accessToken = accessToken
        self.accessTokenExpirationDate = accessTokenExpirationDate
        self.refreshToken = refreshToken
        self.refreshTokenExpirationDate = refreshTokenExpirationDate
        self.accountId = accountId
    }
}
