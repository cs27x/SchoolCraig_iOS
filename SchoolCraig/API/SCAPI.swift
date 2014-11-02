//
//  SCSerializePosting.swift
//  SchoolCraig
//
//  Created by Xiaochen Yang on 11/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation

class SCAPI {
    
    class func parsePosting(json: AnyObject) -> SCPosting {
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
    
    
    class func serializePosting(object: SCPosting) -> AnyObject {
        return []
    }
    
    
    class func parseUser(json: AnyObject) -> SCUser {
        return SCUser(email: json["email"] as String)
    }
    
    
    class func serializeUser(object: SCUser) -> AnyObject {
        // TODO: Implement me!
        return []
    }
    
}