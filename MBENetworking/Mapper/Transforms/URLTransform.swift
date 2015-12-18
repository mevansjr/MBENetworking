//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

public class URLTransform: TransformType {
	public typealias Object = NSURL
	public typealias JSON = String

	public init() {}

	public func transformFromJSON(value: AnyObject?) -> NSURL? {
		if let URLString = value as? String {
			return NSURL(string: URLString)
		}
		return nil
	}

	public func transformToJSON(value: NSURL?) -> String? {
		if let URL = value {
			return URL.absoluteString
		}
		return nil
	}
}
