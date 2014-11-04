//
//  SCPostingRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCAllPostingsRequest: SCNetworkRequest {
    
    var method = SCNetworkMethod.GET
    
    var path = "/post/all"
    
    var onSuccess: ((Array<SCPosting>?) -> ())?
    
    var onError: ((NSError) -> ())?
    
    
    init() {
    
    }
    
    
    func parse(json: AnyObject) -> SCPosting {
        return SCAPI.parsePosting(json)
    }

    
    func parseArray(json: NSArray) -> Array<SCPosting> {
        return (json as Array).map {(var jsonObj) -> (SCPosting) in
            return self.parse(jsonObj)
        }
    }
    
    
    func serialize(object: SCPosting) -> AnyObject {
//        return []
        return SCAPI.parsePosting(object)
    }
    
    
    func serializeArray(objects: Array<SCPosting>) -> NSArray {
        return objects.map {(var obj) -> (AnyObject) in
            return self.serialize(obj)
        }
    }
    
    
}

