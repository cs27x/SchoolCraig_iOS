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
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

        var id = json["id"] as String
        var title = json["title"] as String
        var categoryObj = json["category"] as NSDictionary
        var category = SCCategory(rawValue: categoryObj["id"] as NSString)!
        var details = json["description"] as String
        
        var userObj = json["user"] as NSDictionary
        var author = SCUser(id: userObj["id"] as String, email: userObj["email"] as String)
        var price = (json["cost"] as NSNumber).doubleValue
        var date = dateFormatter.dateFromString(json["date"] as String)
        
        return SCPosting(id: id,
            title: title,
            details: details,
            author: author,
            category: category,
            price: price,
            creationDate: date!)
    }
    
    //serializePosting
    //Takes fields of SCPosting object and converts to JSON
    class func serializePosting(object: SCPosting) -> AnyObject {
        var id = object.id
        var title = object.title
        var category = NSString(string: object.category.rawValue)
        var details = object.details
        var authorId = object.author.id! as NSString
        var cost = NSNumber(double:object.price)
        var timestamp = NSNumber(integer: Int(object.creationDate.timeIntervalSince1970))
        
        return ["id": id,
                "title": title,
                "category_id": category,
                "description": details,
                "user_id": authorId,
                "cost": cost,
                "date": timestamp] as NSDictionary
    }
    
    //parseUser
    //Takes in JSON and marshalls data into SCUser object
    class func parseUser(json: AnyObject) -> SCUser {
        return SCUser(id: json["id"] as String, email: json["email"] as String)
    }
    
    //serializeUser
    //Takes fields of SCUser object and converts to JSON
    class func serializeUser(object: SCUser) -> AnyObject {
        var email = object.email
        return ["email": email] as NSDictionary
    }
    
}