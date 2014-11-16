//
//  SCCreateUserRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/15/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCCreateUserRequest: SCNetworkRequest {
    
    var user: SCUser
    
    var password: String
   
    var method = SCNetworkMethod.POST
    
    var path = "/user"
    
    var onSuccess: ((Array<SCUser>?) -> ())?
    
    var onError: ((NSError) -> ())?
    
    init(user: SCUser, password: String) {
        self.user = user
        self.password = password
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
