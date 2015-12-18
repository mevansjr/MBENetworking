//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
A response deserializer to a generic String object.
*/
public class StringResponseSerializer : ResponseSerializer {
    /**
    Deserialize the response received.
    
    :returns: the serialized response
    */
    public func response(data: NSData) -> (AnyObject?) {
        return NSString(data: data, encoding:NSUTF8StringEncoding)
    }
    
    /**
    Validate the response received.
    
    :returns:  either true or false if the response is valid for this particular serializer.
    */
    public func validateResponse(response: NSURLResponse!, data: NSData) throws {
        var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        let httpResponse = response as! NSHTTPURLResponse
        
        if !(httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
            let userInfo = [
                NSLocalizedDescriptionKey: NSHTTPURLResponse.localizedStringForStatusCode(httpResponse.statusCode),
                NetworkingOperationFailingURLResponseErrorKey: response]

            if (true) {
                error = NSError(domain: HttpResponseSerializationErrorDomain, code: httpResponse.statusCode, userInfo: userInfo)
            }
            
            throw error
        }
    }
    
    public init() {
    }
}