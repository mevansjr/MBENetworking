//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
The protocol that authorization modules must adhere to.
*/
public protocol AuthzModule {

    /**
    Gateway to request authorization access.
    
    :param: completionHandler A block object to be executed when the request operation finishes.
    */
    func requestAccess(completionHandler: (AnyObject?, NSError?) -> Void)

    /**
    Request an authorization code.
    
    :param: completionHandler A block object to be executed when the request operation finishes.
    */
    func requestAuthorizationCode(completionHandler: (AnyObject?, NSError?) -> Void)

    /**
    Exchange an authorization code for an access token.
    
    :param: completionHandler A block object to be executed when the request operation finishes.
    */
    func exchangeAuthorizationCodeForAccessToken(code: String, completionHandler: (AnyObject?, NSError?) -> Void)
    
    /**
    Request to refresh an access token.
    
    :param: completionHandler A block object to be executed when the request operation finishes.
    */
    func refreshAccessToken(completionHandler: (AnyObject?, NSError?) -> Void)
    
    /**
    Request to revoke access.
    
    :param: completionHandler A block object to be executed when the request operation finishes.
    */
    func revokeAccess(completionHandler: (AnyObject?, NSError?) -> Void)
    
    /**
    Return any authorization fields.
    
   :returns:  a dictionary filled with the authorization fields.
    */
    func authorizationFields() -> [String: String]?
    
    /**
    Returns a boolean indicating whether authorization has been granted.
    
    :returns: true if authorized, false otherwise.
    */
    func isAuthorized() -> Bool
    
}