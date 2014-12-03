//
//  SCUserStoreTest.swift
//  SchoolCraig
//
//  Created by Brendan McNamara on 11/9/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit
import XCTest

class SCUserStoreTest: XCTestCase {

    func testAdd() {
        var store = SCUserStore(network: SCLocalNetworkStore(waitTimeInSeconds: 0))
        XCTAssertEqual(0, store.count(),
                       "The user store should have no users before adding users.")
        store.add(SCUser(id: "123",
                         firstName: "Brendan",
                         lastName: "McNamara",
                         email: "brendan.d.mcnamara@vanderbilt.edu"))
        
        XCTAssertEqual(1, store.count(),
                       "The user store should have 1 user after adding the user.")
        
    }
    
    
    func testIteration() {
        var store = SCUserStore(network:SCLocalNetworkStore(waitTimeInSeconds: 0))
        
        var user1 = SCUser(id: "123", firstName: "John", lastName: "Doe", email: "user1@test.com")
        var user2 = SCUser(id: "124", firstName: "Bob", lastName: "Hope", email: "user2@test.com")
        
        store.add(user1)
        store.add(user2)
        
        var didIterateUser1 = false
        var didIterateUser2 = false
        
        for user in store {
            if user == user1 {
                XCTAssertFalse(didIterateUser1, "Iterating user 1 more than once.")
                didIterateUser1 = true
            }
            else if user == user2 {
                XCTAssertFalse(didIterateUser2, "Iterating user2 more than once.")
                didIterateUser2 = true
            }
            else {
                XCTFail("Iterating unrecognizd user.")
            }
        }
        
        XCTAssertTrue(didIterateUser1, "Never iterated user 1.")
        XCTAssertTrue(didIterateUser2, "Never iterated user 2.")
        
    }

    
    func testCreateUser() {
        var network = SCLocalNetworkStore(waitTimeInSeconds: 0)
        var store = SCUserStore(network: network)
        
        var didExecuteCallback = false
        
        var success = {() -> () in
            didExecuteCallback = true
            XCTAssertTrue(network.didCall(endpoint: "/user", method: SCNetworkMethod.POST),
                          "Did not call network for creating a user.")
            
        }
        var error = {(var error: NSError) -> () in
            didExecuteCallback = true
            XCTFail("Creating user produced error.")
        }

        store.createUser(firstName: "John",
                         lastName: "Doe",
                         email: "user@test.com",
                         password: "password",
                         success: success,
                         error: error)
        
        XCTAssertTrue(didExecuteCallback, "store did not execute callback for createUser.")
    }


}

