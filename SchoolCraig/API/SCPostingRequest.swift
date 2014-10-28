//
//  SCPostingRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCPostingRequest: SCNetworkRequest {
    
    var method = SCNetworkMethod.GET
    
    var path = "/posts"
    
    var onSuccess: ((Array<SCPosting>) -> ())?
    
    var onError: ((NSError) -> ())?
    
    
    func parse(json: AnyObject) -> SCPosting {
        return SCPosting(title: "",
                         details: "",
                         author: SCUser(email: ""),
                         category: SCCategory.Dorm,
                         price: 0,
                         creationDate: NSDate())
    }

    
    func parseArray(json: NSArray) -> Array<SCPosting> {
        return (json as Array).map {(var jsonObj) -> (SCPosting) in
            return self.parse(jsonObj)
        }
    }
    
    
    func serialize(object: SCPosting) -> AnyObject {
        return []
    }
    
    
    func serializeArray(objects: Array<SCPosting>) -> NSArray {
        return objects.map {(var obj) -> (AnyObject) in
            return self.serialize(obj)
        }
    }
    
}

