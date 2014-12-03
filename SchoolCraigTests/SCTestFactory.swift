//
//  SCTestFactory.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/9/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCTestFactory {
   
    class func createPostingWithId(id: String) -> SCPosting {
        return SCPosting(id: id,
                         title: "Test Posting",
                         details: "Here is a description of a posting.",
                         author: SCUser(id: "123",
                                        firstName: "John",
                                        lastName: "Doe",
                                        email: "test@test.com"),
                         category: SCCategory.Kitchen,
                         price: 45,
                         creationDate: NSDate())
    }
    
}
