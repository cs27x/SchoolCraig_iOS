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
        var testvar =
            ["id": "myid",
             "title": "mytitle",
             "category": ["id": "bd1eb589-f3d6-47c0-92f4-777a5934f610"] as NSDictionary,
             "description": "mydescription",
             "user": ["email": "email@test.com", "id": "12345"] as NSDictionary,
             "cost": NSNumber(double:0.1),
             "date": "2014-12-02T03:29:55.838Z" as NSString] as NSDictionary

        var post = SCAPI.parsePosting(testvar)
        XCTAssertEqual("myid", post.id, "ID does not match")
        XCTAssertEqual("mytitle", post.title, "Title does not match")
        XCTAssertEqual(SCCategory.Kitchen, post.category, "Category does not match")
        XCTAssertEqual("mydescription", post.details, "Details does not match")
        // TODO: Test that user is valid.
        XCTAssertEqual(0.1, post.price, "Price does not match")
    }
    
    func testSerializePosting() {
        var testuser = SCUser(id: "12345", email: "email")
        var testvar = SCPosting(id: "myid",
                                title: "mytitle",
                                details: "mydescription",
                                author:testuser,
                                category:SCCategory.Kitchen,
                                price:0.1,
                                creationDate:NSDate())

        var json = SCAPI.serializePosting(testvar) as NSDictionary
        
        XCTAssertEqual("myid", json["id"] as NSString, "ID does not match")
        XCTAssertEqual("mytitle", json["title"] as NSString, "Title does not match")
        XCTAssertEqual("bd1eb589-f3d6-47c0-92f4-777a5934f610", json["category_id"] as String, "Category does not match")
        XCTAssertEqual("mydescription", json["description"] as NSString, "Details does not match")
        XCTAssertEqual(NSNumber(double: 0.1), json["cost"] as NSNumber, "Price does not match")
    }
    
    func testParseUser() {
        var testvar = ["id": "12345", "email": "myemail"] as NSDictionary
        var user = SCAPI.parseUser(testvar)
        XCTAssertEqual("myemail", user.email, "email does not match")
    }

    func testSerializeUser() {
        var testuser = SCUser(email: "myemail")
        var json = SCAPI.serializeUser(testuser) as NSDictionary
        XCTAssertEqual("myemail", json["email"] as NSString, "email does not match")
    }
}
