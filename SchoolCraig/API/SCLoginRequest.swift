//
//  SCLoginRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCLoginRequest: SCNetworkRequest {
   
    var email: String
    
    var password: String
    
    var method = SCNetworkMethod.GET
    
    var path = "/user/login"
    
    var onSuccess: ((Array<SCUser>?) -> ())?
    
    var onError: ((NSError) -> ())?
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    
    func parse(json: AnyObject) -> SCUser {
        return SCUser(email: json["email"] as String)
    }
    
    
    func parseArray(json: NSArray) -> Array<SCUser> {
        return (json as Array).map {(var userJson) -> (SCUser) in
            return self.parse(userJson)
        }
    }
    
    
    func serialize(object: SCUser) -> AnyObject {
        // TODO: Implement me!
        return []
    }
    
    func serializeArray(objects: Array<SCUser>) -> NSArray {
        // TODO: Implement me!
        return []
    }
}