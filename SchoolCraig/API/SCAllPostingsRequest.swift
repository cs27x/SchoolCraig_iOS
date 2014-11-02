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
        var id = json["id"] as String
        var title = json["title"] as String
        var details = json["description"] as String
        var author = SCUser(email: json["author"] as String)
        var price = (json["price"] as NSNumber).doubleValue
        var timestamp = json["date"] as NSNumber
        var date = NSDate(timeIntervalSince1970: Double(timestamp))
        
        return SCPosting(id: id,
                         title: title,
                         details: details,
                         author: author,
                         category: SCCategory.Dorm,
                         price: price,
                         creationDate: date)
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

