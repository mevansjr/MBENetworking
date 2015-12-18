//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

public class DateFormatterTransform: TransformType {
	public typealias Object = NSDate
	public typealias JSON = String
	
	let dateFormatter: NSDateFormatter
	
	public init(dateFormatter: NSDateFormatter) {
		self.dateFormatter = dateFormatter
	}
	
	public func transformFromJSON(value: AnyObject?) -> NSDate? {
		if let dateString = value as? String {
			return dateFormatter.dateFromString(dateString)
		}
		return nil
	}
	
	public func transformToJSON(value: NSDate?) -> String? {
		if let date = value {
			return dateFormatter.stringFromDate(date)
		}
		return nil
	}
}