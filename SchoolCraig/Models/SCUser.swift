//
//  SCUser.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCUser: Equatable {
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    
}


func == (user1: SCUser, user2: SCUser) -> Bool {
    return user1.email == user2.email
}
