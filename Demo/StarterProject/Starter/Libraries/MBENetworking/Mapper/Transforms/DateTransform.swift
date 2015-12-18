//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

public class DateTransform: TransformType {
	public typealias Object = NSDate
	public typealias JSON = Double

	public init() {}

	public func transformFromJSON(value: AnyObject?) -> NSDate? {
		if let timeInt = value as? Double {
			return NSDate(timeIntervalSince1970: NSTimeInterval(timeInt))
		}
		return nil
	}

	public func transformToJSON(value: NSDate?) -> Double? {
		if let date = value {
			return Double(date.timeIntervalSince1970)
		}
		return nil
	}
}
