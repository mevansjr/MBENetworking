//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
The protocol that request serializers must adhere to.
*/
public protocol RequestSerializer {
    
    /// The url that this request serializer is bound to.
    var url: NSURL? { get set }
    /// Any headers that will be appended on the request.
    var headers: [String: String]? { get set }
    /// The String encoding to be used.
    var stringEncoding: NSNumber { get }
    ///  The cache policy.
    var cachePolicy: NSURLRequestCachePolicy { get }
    /// The timeout interval.
    var timeoutInterval: NSTimeInterval { get set }
    
    /**
    Build an request using the specified params passed in.
    
    :param: url the url of the resource.
    :param: method the method to be used.
    :param: parameters the request parameters.
    :param: headers any headers to be used on this request.
    
    :returns: the URLRequest object.
    */
    func request(url: NSURL, method: HttpMethod, parameters: [String: AnyObject]?, headers: [String: String]?) -> NSURLRequest
    
    /**
    Build an multipart request using the specified params passed in.
    
    :param: url the url of the resource.
    :param: method the method to be used.
    :param: parameters the request parameters.
    :param: headers any headers to be used on this request.
    
    :returns: the URLRequest object
   */
    func multipartRequest(url: NSURL, method: HttpMethod, parameters: [String: AnyObject]?, headers: [String: String]?) -> NSURLRequest
}