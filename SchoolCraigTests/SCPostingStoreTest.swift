//
//  SCPostingStoreTest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/9/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit
import XCTest

class SCPostingStoreTest: XCTestCase {

    
    func testAdd() {
        var store = SCPostingStore(network: SCLocalNetworkStore(waitTimeInSeconds: 0))
        XCTAssertEqual(0, store.count(), "There should be no items in the store when initialized.")
        var posting = SCTestFactory.createPostingWithId("12345")
        store.add(posting)
        
        XCTAssertEqual(1, store.count(), "Incorrect number of postings in the store.")
        XCTAssertEqual(posting, store[posting.id]!, "Posting should be added to the store.")
    }

    func testIteration() {
        var store = SCPostingStore(network: SCLocalNetworkStore(waitTimeInSeconds: 0))
        var posting1 = SCTestFactory.createPostingWithId("12345")
        var posting2 = SCTestFactory.createPostingWithId("123456")
        store.add(posting1)
        store.add(posting2)
        
        var iterationCount = 0
        var iteratedPosting1 = false
        var iteratedPosting2 = false
        
        for posting in store {
            // Make sure that each of the 2 elements in the collection
            // is iterated exactly once.
            ++iterationCount
            if posting == posting1 {
                XCTAssertFalse(iteratedPosting1, "Iterated posting1 more than once.")
                iteratedPosting1 = true
            }
            else if posting == posting2 {
                XCTAssertFalse(iteratedPosting2, "Iterated posting2 more than once.")
                iteratedPosting2 = true
            }
            else {
                XCTFail("Iterating unrecognized posting.")
            }
        }
        
        XCTAssertEqual(2, iterationCount, "Should have iterated the store 2 times.")
    }

}
