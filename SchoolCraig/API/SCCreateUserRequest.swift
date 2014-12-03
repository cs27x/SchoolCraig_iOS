//
//  SCCreateUserRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/15/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCCreateUserRequest: SCNetworkRequest {
    
    var firstName: String
    
    var lastName: String
    
    var email: String
    
    var password: String
   
    var method = SCNetworkMethod.POST
    
    var path = "/user"
    
    var onSuccess: ((Array<SCUser>?) -> ())?
    
    var onError: ((NSError) -> ())?
    
    init(firstName: String, lastName: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    
    func body() -> NSDictionary? {
        return ["fname": firstName as NSString,
                "lname": lastName as NSString,
                "email": email as NSString,
                "password": password as NSString] as NSDictionary
    }
    
    
    func parse(json: AnyObject) -> SCUser {
        return SCAPI.parseUser(json)
    }
    
    func parseArray(json: NSArray) -> Array<SCUser> {
        return (json as Array).map {(var obj) -> (SCUser) in
            return self.parse(obj)
        }
    }
    
    func serialize(object: SCUser) -> AnyObject {
        return SCAPI.serializeUser(object)
    }
    
    func serializeArray(objects: Array<SCUser>) -> NSArray {
        return (objects as Array).map {(var user) -> (AnyObject) in
            return self.serialize(user)
        }
    }
    
}
