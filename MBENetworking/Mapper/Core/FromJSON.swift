//  Created by Mark Evans on 12/18/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

internal final class FromJSON {
	
	/// Basic type
	class func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType?, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Implicitly unwrapped optional basic type
	class func optionalBasicType<FieldType>(inout field: FieldType!, object: FieldType?) {
		if let value = object {
			field = value
		}
	}

	/// Mappable object
	class func object<N: Mappable>(inout field: N, map: Map) {
		if map.toObject {
			Mapper().map(map.currentValue, toObject: field)
		} else if let value: N = Mapper().map(map.currentValue) {
			field = value
		}
	}

	/// Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N?, map: Map) {
		if let field = field where map.toObject {
			Mapper().map(map.currentValue, toObject: field)
		} else {
			field = Mapper().map(map.currentValue)
		}
	}

	/// Implicitly unwrapped Optional Mappable Object
	class func optionalObject<N: Mappable>(inout field: N!, map: Map) {
		if let field = field where map.toObject {
			Mapper().map(map.currentValue, toObject: field)
		} else {
			field = Mapper().map(map.currentValue)
		}
	}

	/// mappable object array
	class func objectArray<N: Mappable>(inout field: Array<N>, map: Map) {
		if let objects = Mapper<N>().mapArray(map.currentValue) {
			field = objects
		}
	}

	/// optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>?, map: Map) {
		field = Mapper().mapArray(map.currentValue)
	}

	/// Implicitly unwrapped optional mappable object array
	class func optionalObjectArray<N: Mappable>(inout field: Array<N>!, map: Map) {
		field = Mapper().mapArray(map.currentValue)
	}
	
	/// mappable object array
	class func twoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>, map: Map) {
		if let objects = Mapper<N>().mapArrayOfArrays(map.currentValue) {
			field = objects
		}
	}
	
	/// optional mappable 2 dimentional object array
	class func optionalTwoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>?, map: Map) {
		field = Mapper().mapArrayOfArrays(map.currentValue)
	}
	
	/// Implicitly unwrapped optional 2 dimentional mappable object array
	class func optionalTwoDimensionalObjectArray<N: Mappable>(inout field: Array<Array<N>>!, map: Map) {
		field = Mapper().mapArrayOfArrays(map.currentValue)
	}
	
	/// Dctionary containing Mappable objects
	class func objectDictionary<N: Mappable>(inout field: Dictionary<String, N>, map: Map) {
		if map.toObject {
			Mapper<N>().mapDictionary(map.currentValue, toDictionary: field)
		} else {
			if let objects = Mapper<N>().mapDictionary(map.currentValue) {
				field = objects
			}	
		}
	}

	/// Optional dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>?, map: Map) {
		if let field = field where map.toObject {
			Mapper().mapDictionary(map.currentValue, toDictionary: field)
		} else {
			field = Mapper().mapDictionary(map.currentValue)
		}
	}

	/// Implicitly unwrapped Dictionary containing Mappable objects
	class func optionalObjectDictionary<N: Mappable>(inout field: Dictionary<String, N>!, map: Map) {
		if let field = field where map.toObject {
			Mapper().mapDictionary(map.currentValue, toDictionary: field)
		} else {
			field = Mapper().mapDictionary(map.currentValue)
		}
	}
	
	/// Dictionary containing Array of Mappable objects
	class func objectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>, map: Map) {
		if let objects = Mapper<N>().mapDictionaryOfArrays(map.currentValue) {
			field = objects
		}
	}
	
	/// Optional Dictionary containing Array of Mappable objects
	class func optionalObjectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>?, map: Map) {
		field = Mapper<N>().mapDictionaryOfArrays(map.currentValue)
	}
	
	/// Implicitly unwrapped Dictionary containing Array of Mappable objects
	class func optionalObjectDictionaryOfArrays<N: Mappable>(inout field: Dictionary<String, [N]>!, map: Map) {
		field = Mapper<N>().mapDictionaryOfArrays(map.currentValue)
	}

	
	/// mappable object Set
	class func objectSet<N: Mappable>(inout field: Set<N>, map: Map) {
		if let objects = Mapper<N>().mapSet(map.currentValue) {
			field = objects
		}
	}
	
	/// optional mappable object array
	class func optionalObjectSet<N: Mappable>(inout field: Set<N>?, map: Map) {
		field = Mapper().mapSet(map.currentValue)
	}
	
	/// Implicitly unwrapped optional mappable object array
	class func optionalObjectSet<N: Mappable>(inout field: Set<N>!, map: Map) {
		field = Mapper().mapSet(map.currentValue)
	}
	
}
