//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/** 
Error domain for serializers.
*/
public let HttpResponseSerializationErrorDomain = "ResponseSerializerDomain"

/**
The protocol that response serializers must adhere to.
*/
public protocol ResponseSerializer {
    
    /**
     Deserialize the response received.

     :returns: the serialized response
    */
    func response(data: NSData) -> (AnyObject?)
    
    /**
     Validate the response received.
    
     :returns:  either true or false if the response is valid for this particular serializer.
    */
    func validateResponse(response: NSURLResponse!, data: NSData) throws
}