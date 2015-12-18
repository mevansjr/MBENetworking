//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

public protocol TransformType {
	typealias Object
	typealias JSON

	func transformFromJSON(value: AnyObject?) -> Object?
	func transformToJSON(value: Object?) -> JSON?
}
