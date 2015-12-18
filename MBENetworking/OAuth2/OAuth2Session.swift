//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
The protocol that an OAuth2 Session modules must adhere to and represent storage of oauth specific metadata. See TrustedPersistantOAuth2Session and UntrustedMemoryOAuth2Session as example implementations
*/
public protocol OAuth2Session {
    
    /**
    The account id.
    */
    var accountId: String {get}
    
    /**
    The access token which expires.
    */
    var accessToken: String? {get set}
    
    /**
    The access token's expiration date.
    */
     var accessTokenExpirationDate: NSDate? {get set}
    
    /**
    The refresh token's expiration date.
    */
    var refreshTokenExpirationDate: NSDate? {get set}
    
    /**
    The refresh tokens. This toke does not expire and should be used to renew access token when expired.
    */
    var refreshToken: String? {get set}
    
    /**
    Check validity of accessToken. return true if still valid, false when expired.
    */
    func tokenIsNotExpired() -> Bool
    
    
    /**
    Check validity of refreshToken. return true if still valid, false when expired.
    */
    func refreshTokenIsNotExpired() -> Bool
    
    /**
    Clears any tokens storage
    */
    func clearTokens()
    
    /**
    Save tokens information. Saving tokens allow you to refresh accesstoken transparently for the user without prompting
    for grant access.
    
    :param: accessToken the access token.
    :param: refreshToken the refresh token.
    :param: accessTokenExpiration the expiration for the access token.
    :param: refreshTokenExpiration the expiration for the refresh token.
    */
    func saveAccessToken(accessToken: String?, refreshToken: String?, accessTokenExpiration: String?, refreshTokenExpiration: String?)
}
