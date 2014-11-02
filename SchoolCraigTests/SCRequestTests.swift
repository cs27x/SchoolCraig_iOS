//
//  SCRequestTests.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit
import XCTest

class SCRequestTests: XCTestCase {

    func testLoginRequest() {
        var callbackIsCalled = false;
        var request = SCLoginRequest(email: "brendan.d.mcnamara@vanderbilt.edu",
                                     password: "password")

        request.onSuccess = {(var userArray) -> () in
            callbackIsCalled = true;
            if let _userArray = userArray {
                XCTAssertEqual(1, countElements(_userArray), "Array should contain 1 user")
            }
            else {
                XCTFail("Array optional from login request should not be nil optional")
            }
        }
        
        request.onError = {(var error) -> () in
            callbackIsCalled = true;
            XCTFail("login request onError was executed: \(error)")
        }
        
        var networkStore = SCLocalNetworkStore(waitTimeInSeconds: 0)
        networkStore.handleRequest(request)

        XCTAssertTrue(callbackIsCalled, "Expect onSuccess to be called for login request")
    }
    

    func testAllPostingsRequest() {
        
    }


}
