//
//  SCSerializePosting.swift
//  SchoolCraig
//
//  Created by Xiaochen Yang on 11/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation

class SCAPI {
    
    
    //parsePosting
    //Takes in JSON and marshalls data into SCPosting object
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
    
    //serializePosting
    //Takes fields of SCPosting object and converts to JSON
    class func serializePosting(object: SCPosting) -> AnyObject {
        var id = object.id
        var title = object.title
        var category = NSNumber(integer: object.category.rawValue)
        var details = object.details
        var author = object.author
        var price = NSNumber(double:object.price)
        var timestamp = NSNumber(integer: Int(object.creationDate.timeIntervalSince1970))
        
        return ["id": id, "title": title, "category": category, "description": details,
            "author": author, "price": price, "date": timestamp] as NSDictionary
    }
    
    //parseUser
    //Takes in JSON and marshalls data into SCUser object
    class func parseUser(json: AnyObject) -> SCUser {
        return SCUser(email: json["email"] as String)
    }
    
    //serializeUser
    //Takes fields of SCUser object and converts to JSON
    class func serializeUser(object: SCUser) -> AnyObject {
        var email = object.email
        return ["email": email] as NSDictionary
    }
    
}