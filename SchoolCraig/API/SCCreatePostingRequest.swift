//
//  SCCreatePostingRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCCreatePostingRequest: SCNetworkRequest {
   
    var method = SCNetworkMethod.POST
    
    var path = "/post"
    
    var onSuccess: ((Array<SCPosting>?) -> ())?
    
    var onError: ((NSError) -> ())?
    
    
    func serialize(object: SCPosting) -> AnyObject {
        // TODO (brendan): Implement me!
        return []
    }

    func serializeArray(objects: Array<SCPosting>) -> NSArray {
        // TODO (brendan): Implement me
        return []
    }
    
    func parse(json: AnyObject) -> SCPosting {
        // TODO (brendan): This is copied code. Find a better
        // place for it.
        var id = json["id"] as String
        var title = json["title"] as String
        var category =
            SCCategory(rawValue:(json["category"] as NSNumber).integerValue)!
        var details = json["description"] as String
        var author = SCUser(email: json["author"] as String)
        var price = (json["price"] as NSNumber).doubleValue
        var timestamp = json["date"] as NSNumber
        var date = NSDate(timeIntervalSince1970: Double(timestamp))
        
        return SCPosting(id: id,
            title: title,
            details: details,
            author: author,
            category: category,
            price: price,
            creationDate: date)
    }
    
    
    func parseArray(json: NSArray) -> Array<SCPosting> {
        return (json as Array<AnyObject>).map {(var jsonObj) -> (SCPosting) in
            return self.parse(jsonObj)
        }
    }
    
    
}
