//
//  SCUser.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCUser: Equatable {
    
    var id: String?

    var email: String
    
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
    
    init(email: String) {
        self.email = email
    }
    
    // Check if this is a new user.
    func isNew() -> Bool {
        return self.id == nil
    }
    

}

func == (user1: SCUser, user2: SCUser) -> Bool {
    return user1.email == user2.email
}