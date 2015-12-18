//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

infix operator <- {}

// MARK:- Objects with Basic types

/// Object of Basic type
public func <- <T>(inout left: T, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.basicType(&left, object: right.value())
    } else {
		ToJSON.basicType(left, map: right)
    }
}

/// Optional object of basic type
public func <- <T>(inout left: T?, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalBasicType(&left, object: right.value())
    } else {
        ToJSON.optionalBasicType(left, map: right)
    }
}

/// Implicitly unwrapped optional object of basic type
public func <- <T>(inout left: T!, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalBasicType(&left, object: right.value())
	} else {
		ToJSON.optionalBasicType(left, map: right)
	}
}

// MARK:- Raw Representable types

/// Object of Raw Representable type
public func <- <T: RawRepresentable>(inout left: T, right: Map) {
	left <- (right, EnumTransform())
}

/// Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(inout left: T?, right: Map) {
	left <- (right, EnumTransform())
}

/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(inout left: T!, right: Map) {
	left <- (right, EnumTransform())
}

// MARK:- Arrays of Raw Representable type

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [T], right: Map) {
	left <- (right, EnumTransform())
}

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [T]?, right: Map) {
	left <- (right, EnumTransform())
}

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [T]!, right: Map) {
	left <- (right, EnumTransform())
}

// MARK:- Dictionaries of Raw Representable type

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [String: T], right: Map) {
	left <- (right, EnumTransform())
}

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [String: T]?, right: Map) {
	left <- (right, EnumTransform())
}

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [String: T]!, right: Map) {
	left <- (right, EnumTransform())
}

// MARK:- Transforms

/// Object of Basic type with Transform
public func <- <Transform: TransformType>(inout left: Transform.Object, right: (Map, Transform)) {
	let (map, transform) = right
    if map.mappingType == MappingType.FromJSON {
        let value = transform.transformFromJSON(map.currentValue)
        FromJSON.basicType(&left, object: value)
    } else {
        let value: Transform.JSON? = transform.transformToJSON(left)
		ToJSON.optionalBasicType(value, map: map)
    }
}

/// Optional object of basic type with Transform
public func <- <Transform: TransformType>(inout left: Transform.Object?, right: (Map, Transform)) {
	let (map, transform) = right
    if map.mappingType == MappingType.FromJSON {
        let value = transform.transformFromJSON(map.currentValue)
        FromJSON.optionalBasicType(&left, object: value)
    } else {
        let value: Transform.JSON? = transform.transformToJSON(left)
        ToJSON.optionalBasicType(value, map: map)
    }
}

/// Implicitly unwrapped optional object of basic type with Transform
public func <- <Transform: TransformType>(inout left: Transform.Object!, right: (Map, Transform)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let value = transform.transformFromJSON(map.currentValue)
		FromJSON.optionalBasicType(&left, object: value)
	} else {
		let value: Transform.JSON? = transform.transformToJSON(left)
		ToJSON.optionalBasicType(value, map: map)
	}
}

/// Array of Basic type with Transform
public func <- <Transform: TransformType>(inout left: [Transform.Object], right: (Map, Transform)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		FromJSON.basicType(&left, object: values)
	} else {
		let values = toJSONArrayWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Optional array of Basic type with Transform
public func <- <Transform: TransformType>(inout left: [Transform.Object]?, right: (Map, Transform)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONArrayWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Implicitly unwrapped optional array of Basic type with Transform
public func <- <Transform: TransformType>(inout left: [Transform.Object]!, right: (Map, Transform)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONArrayWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Dictionary of Basic type with Transform
public func <- <Transform: TransformType>(inout left: [String: Transform.Object], right: (Map, Transform)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		FromJSON.basicType(&left, object: values)
	} else {
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Optional dictionary of Basic type with Transform
public func <- <Transform: TransformType>(inout left: [String: Transform.Object]?, right: (Map, Transform)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

/// Implicitly unwrapped optional dictionary of Basic type with Transform
public func <- <Transform: TransformType>(inout left: [String: Transform.Object]!, right: (Map, Transform)) {
	let (map, transform) = right
	if map.mappingType == MappingType.FromJSON {
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		FromJSON.optionalBasicType(&left, object: values)
	} else {
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		ToJSON.optionalBasicType(values, map: map)
	}
}

private func fromJSONArrayWithTransform<Transform: TransformType>(input: AnyObject?, transform: Transform) -> [Transform.Object]? {
	if let values = input as? [AnyObject] {
		return values.flatMap { value in
			return transform.transformFromJSON(value)
		}
	} else {
		return nil
	}
}

private func fromJSONDictionaryWithTransform<Transform: TransformType>(input: AnyObject?, transform: Transform) -> [String: Transform.Object]? {
	if let values = input as? [String: AnyObject] {
		return values.filterMap { value in
			return transform.transformFromJSON(value)
		}
	} else {
		return nil
	}
}

private func toJSONArrayWithTransform<Transform: TransformType>(input: [Transform.Object]?, transform: Transform) -> [Transform.JSON]? {
	return input?.flatMap { value in
		return transform.transformToJSON(value)
	}
}

private func toJSONDictionaryWithTransform<Transform: TransformType>(input: [String: Transform.Object]?, transform: Transform) -> [String: Transform.JSON]? {
	return input?.filterMap { value in
		return transform.transformToJSON(value)
	}
}

// MARK:- Mappable Objects - <T: Mappable>

/// Object conforming to Mappable
public func <- <T: Mappable>(inout left: T, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.object(&left, map: right)
    } else {
		ToJSON.object(left, map: right)
    }
}

/// Optional Mappable objects
public func <- <T: Mappable>(inout left: T?, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalObject(&left, map: right)
    } else {
		ToJSON.optionalObject(left, map: right)
    }
}

/// Implicitly unwrapped optional Mappable objects
public func <- <T: Mappable>(inout left: T!, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObject(&left, map: right)
	} else {
		ToJSON.optionalObject(left, map: right)
	}
}

// MARK:- Dictionary of Mappable objects - Dictionary<String, T: Mappable>

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, T>, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.objectDictionary(&left, map: right)
    } else {
        ToJSON.objectDictionary(left, map: right)
    }
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, T>?, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalObjectDictionary(&left, map: right)
    } else {
        ToJSON.optionalObjectDictionary(left, map: right)
    }
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, T>!, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectDictionary(&left, map: right)
	} else {
		ToJSON.optionalObjectDictionary(left, map: right)
	}
}

/// Dictionary of Mappable objects <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, [T]>, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.objectDictionaryOfArrays(&left, map: right)
	} else {
		ToJSON.objectDictionaryOfArrays(left, map: right)
	}
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, [T]>?, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	} else {
		ToJSON.optionalObjectDictionaryOfArrays(left, map: right)
	}
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <- <T: Mappable>(inout left: Dictionary<String, [T]>!, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	} else {
		ToJSON.optionalObjectDictionaryOfArrays(left, map: right)
	}
}

// MARK:- Array of Mappable objects - Array<T: Mappable>

/// Array of Mappable objects
public func <- <T: Mappable>(inout left: Array<T>, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.objectArray(&left, map: right)
    } else {
		ToJSON.objectArray(left, map: right)
    }
}

/// Optional array of Mappable objects
public func <- <T: Mappable>(inout left: Array<T>?, right: Map) {
    if right.mappingType == MappingType.FromJSON {
        FromJSON.optionalObjectArray(&left, map: right)
    } else {
		ToJSON.optionalObjectArray(left, map: right)
    }
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: Mappable>(inout left: Array<T>!, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectArray(&left, map: right)
	} else {
		ToJSON.optionalObjectArray(left, map: right)
	}
}

// MARK:- Array of Array of Mappable objects - Array<Array<T: Mappable>>

/// Array of Array Mappable objects
public func <- <T: Mappable>(inout left: Array<Array<T>>, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.twoDimensionalObjectArray(&left, map: right)
	} else {
		ToJSON.twoDimensionalObjectArray(left, map: right)
	}
}

/// Optional array of Mappable objects
public func <- <T: Mappable>(inout left:Array<Array<T>>?, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	} else {
		ToJSON.optionalTwoDimensionalObjectArray(left, map: right)
	}
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: Mappable>(inout left: Array<Array<T>>!, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	} else {
		ToJSON.optionalTwoDimensionalObjectArray(left, map: right)
	}
}

// MARK:- Set of Mappable objects - Set<T: Mappable where T: Hashable>

/// Array of Mappable objects
public func <- <T: Mappable where T: Hashable>(inout left: Set<T>, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.objectSet(&left, map: right)
	} else {
		ToJSON.objectSet(left, map: right)
	}
}


/// Optional array of Mappable objects
public func <- <T: Mappable where T: Hashable>(inout left: Set<T>?, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectSet(&left, map: right)
	} else {
		ToJSON.optionalObjectSet(left, map: right)
	}
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <- <T: Mappable where T: Hashable>(inout left: Set<T>!, right: Map) {
	if right.mappingType == MappingType.FromJSON {
		FromJSON.optionalObjectSet(&left, map: right)
	} else {
		ToJSON.optionalObjectSet(left, map: right)
	}
}
