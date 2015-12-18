//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
Handy extensions and utilities.
*/
extension String {
    
    public func urlEncode() -> String {
        let encodedURL = CFURLCreateStringByAddingPercentEscapes(nil,
            self as NSString,
            nil,
            "!@#$%&*'();:=+,/?[]",
            CFStringBuiltInEncodings.UTF8.rawValue)
        return encodedURL as String
    }
}
