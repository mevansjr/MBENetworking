//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

public class EnumTransform<T: RawRepresentable>: TransformType {
	public typealias Object = T
	public typealias JSON = T.RawValue
	
	public init() {}
	
	public func transformFromJSON(value: AnyObject?) -> T? {
		if let raw = value as? T.RawValue {
			return T(rawValue: raw)
		}
		return nil
	}
	
	public func transformToJSON(value: T?) -> T.RawValue? {
		if let obj = value {
			return obj.rawValue
		}
		return nil
	}
}