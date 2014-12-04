//
//  SCCreatePostingRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCCreatePostingRequest: SCNetworkRequest {
   
    var posting: SCPosting
    
    var method = SCNetworkMethod.POST
    
    var path = "/post"
    
    var onSuccess: ((Array<SCPosting>?) -> ())?
    
    var onError: ((NSError) -> ())?
    
    init(posting: SCPosting) {
        self.posting = posting
    }
    
    
    func body() -> NSDictionary? {
        return ["title": posting.title as NSString,
                "description": posting.details as NSString,
                "user_id": posting.author.id,
                "category_id": posting.category.rawValue as NSString,
                "cost": posting.price as NSNumber] as NSDictionary
    }
    
    func serialize(object: SCPosting) -> AnyObject {
        // TODO (brendan): Implement me!
        return SCAPI.serializePosting(object)
    }

    
    func serializeArray(objects: Array<SCPosting>) -> NSArray {
        // TODO (brendan): Implement me
        return []
    }
    
    
    func parse(json: AnyObject) -> SCPosting {
        return SCAPI.parsePosting(json)
    }
    
    
    func parseArray(json: NSArray) -> Array<SCPosting> {
        return (json as Array<AnyObject>).map {(var jsonObj) -> (SCPosting) in
            return self.parse(jsonObj)
        }
    }
    
    
}
