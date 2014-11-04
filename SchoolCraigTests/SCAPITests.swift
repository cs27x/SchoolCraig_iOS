//
//  SCAPITests.swift
//  SchoolCraig
//
//  Created by William Pascucci on 11/3/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit
import XCTest

class SCAPITests: XCTestCase {
    
    func testParsePosting() {
        var testvar = ["id": "myid", "title": "mytitle", "category": NSNumber(integer: 0), "description": "mydescription", "author": "myauthor", "price": NSNumber(double:0.1), "date": NSNumber(integer:12345)] as NSDictionary
        var post = SCAPI.parsePosting(testvar)
        XCTAssertEqual("myid", post.id, "ID does not match")
        XCTAssertEqual("mytitle", post.title, "Title does not match")
        XCTAssertEqual(SCCategory.Kitchen, post.category, "Category does not match")
        XCTAssertEqual("mydescription", post.details, "Details does not match")
        // TODO: Test that user is valid.
        XCTAssertEqual(0.1, post.price, "Price does not match")
    }
    
    func testSerializePosting() {
        var testuser = SCUser(email: "email")
        var testvar = SCPosting(id: "myid",title: "mytitle",details: "mydescription",
            author:testuser, category:SCCategory.Kitchen,price:0.1,creationDate:NSDate())
        var json = SCAPI.serializePosting(testvar) as NSDictionary
        
        XCTAssertEqual("myid", json["id"] as NSString, "ID does not match")
        XCTAssertEqual("mytitle", json["title"] as NSString, "Title does not match")
        XCTAssertEqual(NSNumber(integer: 0), json["category"] as NSNumber, "Category does not match")
        XCTAssertEqual("mydescription", json["description"] as NSString, "Details does not match")
        XCTAssertEqual(NSNumber(double: 0.1), json["price"] as NSNumber, "Price does not match")
    }
    
    func testParseUser() {
        var testvar = ["email": "myemail"] as NSDictionary
        var user = SCAPI.parseUser(testvar)
        XCTAssertEqual("myemail", user.email, "email does not match")
    }

    func testSerializeUser() {
        var testuser = SCUser(email: "myemail")
        var json = SCAPI.serializeUser(testuser) as NSDictionary
        XCTAssertEqual("myemail", json["email"] as NSString, "email does not match")
    }
}
