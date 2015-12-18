//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

/**
Handy extensions to NSDate
*/
extension NSDate
{
    
    /**
    Initialize a date object using the given string.
    
    :param: dateString the string that will be used to instantiate the date object. The string is expected to be in the format 'yyyy-MM-dd hh:mm:ss a'.
    
    :returns: the NSDate object.
    */
    public convenience init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        let d = dateStringFormatter.dateFromString(dateString)
        if let unwrappedDate = d {
            self.init(timeInterval:0, sinceDate:unwrappedDate)
        } else {
            self.init()
        }
    }
    
    
    /**
    Returns a string of the date object using the format 'yyyy-MM-dd hh:mm:ss a'.
    
    :returns: a formatted string object.
    */
    public func toString() -> String {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        return dateStringFormatter.stringFromDate(self)
    }
}