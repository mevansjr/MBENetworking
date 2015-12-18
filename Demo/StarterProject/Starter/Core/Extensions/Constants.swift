//
//  Constants.swift
//  Starter
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

struct Global {
    static let API_BASE_DOMAIN = "http://api.openweathermap.org" // Enter api url example: https://api.domain.com
    static let API_VERSION = "v1" // Most api's have a version (optional)
    static let API_CLIENT_ID = ""
    static let API_CLIENT_SECRET = ""
    static let API_ACCESS_TOKEN = "AccessToken"
    static let API_REFRESH_TOKEN = "RefreshToken"
    static let API_TOKEN_EXPIRE_DATE = "TokenExpireDate"
    static let APP_FIRST_LOAD = "AppFirstLoad"
}

extension Dictionary {
    
    func filter(predicate: Element -> Bool) -> Dictionary {
        var filteredDictionary = Dictionary()
        
        for (key, value) in self {
            if predicate(key, value) {
                filteredDictionary[key] = value
            }
        }
        
        return filteredDictionary
    }
    
    func queryStringWithEncoding() -> String {
        var parts = [String]()
        
        for (key, value) in self {
            let keyString: String = "\(key)"
            let valueString: String = "\(value)"
            let query: String = "\(keyString)=\(valueString)"
            parts.append(query)
        }
        
        return parts.joinWithSeparator("&")
    }
    
    func urlEncodedQueryStringWithEncoding() -> String {
        var parts = [String]()
        
        for (key, value) in self {
            let keyString: String = "\(key)"
            let valueString: String = "\(value)"
            let query: String = "\(keyString)=\(valueString)"
            parts.append(query)
        }
        
        return parts.joinWithSeparator("&")
    }
    
}

infix operator +| {}
func +| <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}
