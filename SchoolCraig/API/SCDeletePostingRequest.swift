//
//  SCDeletePostRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 12/3/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCDeletePostingRequest: SCNetworkRequest {
   
    var posting: SCPosting
    
    var method = SCNetworkMethod.DELETE
    
    var path: String {
        get {
            return "/post/" + posting.id
        }
    }
    
    var onSuccess: ((Array<SCPosting>?) -> ())?
    
    var onError: ((NSError) -> ())?
    
    init(posting: SCPosting) {
        self.posting = posting
    }
    
    func body() -> NSDictionary? {
        return nil
    }
    
    func parse(json: AnyObject) -> SCPosting {
        return SCAPI.parsePosting(json)
    }
    
    func parseArray(json: NSArray) -> Array<SCPosting> {
        return (json as Array<AnyObject>).map {(var postingJson) -> (SCPosting) in
            return self.parse(postingJson)
        }
    }
    
    func serialize(object: SCPosting) -> AnyObject {
        return []
    }
    
    func serializeArray(objects: Array<SCPosting>) -> NSArray {
        return []
    }

}
