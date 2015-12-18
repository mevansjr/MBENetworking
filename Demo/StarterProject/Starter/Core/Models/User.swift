//
//  User.swift
//  Cover5
//
//  Created by Mark Evans on 4/16/15.
//  Copyright (c) 2015 3Advance, LLC. All rights reserved.
//

import UIKit

public class OAuth: Mappable {
    
    var access_token: String?
    var refresh_token: String?
    var expires_in: Int?
    var username: String?
    var password: String?
    var grant_type: String?
    var client_id: String?
    var client_secret: String?
    var issued: String?
    var expires: String?
    
    public required init?(_ map: Map) {
        mapping(map)
    }
    public required init(){}
    
    public func mapping(map: Map) {
        access_token <- map["access_token"]
        refresh_token <- map["refresh_token"]
        expires_in <- map["expires_in"]
        username <- map["username"]
        password <- map["password"]
        grant_type <- map["grant_type"]
        client_id <- map["client_id"]
        client_secret <- map["client_secret"]
        issued <- map[".issued"]
        expires <- map[".expires"]
    }
}

public class User: Mappable {
    
    var UserId: Int?
    var Email: String?
    var UserName: String?
    var Password: String?
    var CreatedDate: String?
    var LastName: String?
    var FirstName: String?
    
    public required init?(_ map: Map) {
        mapping(map)
    }
    public required init(){}
    
    public func mapping(map: Map) {
        UserId <- map["UserId"]
        Email <- map["Email"]
        UserName <- map["UserName"]
        Password <- map["Password"]
        LastName <- map["LastName"]
        FirstName <- map["FirstName"]
        CreatedDate <- map["CreatedDate"]
    }
}