//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

public class TransformOf<ObjectType, JSONType>: TransformType {
	public typealias Object = ObjectType
	public typealias JSON = JSONType

	private let fromJSON: JSONType? -> ObjectType?
	private let toJSON: ObjectType? -> JSONType?

	public init(fromJSON: JSONType? -> ObjectType?, toJSON: ObjectType? -> JSONType?) {
		self.fromJSON = fromJSON
		self.toJSON = toJSON
	}

	public func transformFromJSON(value: AnyObject?) -> ObjectType? {
		return fromJSON(value as? JSONType)
	}

	public func transformToJSON(value: ObjectType?) -> JSONType? {
		return toJSON(value)
	}
}
