//
//  SCUser.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCUser: Equatable {
    
    var id: String

    var email: String
    
    var firstName: String
    
    var lastName: String
    
    init(id: String, firstName: String, lastName: String, email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    

}

func == (user1: SCUser, user2: SCUser) -> Bool {
    return user1.id == user2.id
}