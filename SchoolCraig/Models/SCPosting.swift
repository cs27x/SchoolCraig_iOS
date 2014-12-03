//
//  SCPosting.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCPosting: Equatable {
    
    var id: String
    
    var title: String
    
    var details: String
    
    var author: SCUser
    
    var category: SCCategory
    
    var price: Double
    
    var creationDate: NSDate

    init(id: String,
         title: String,
         details: String,
         author: SCUser,
         category: SCCategory,
         price: Double,
         creationDate: NSDate) {

            self.id = id;
            self.title = title
            self.details = details
            self.author = author;
            self.category = category
            self.price = price
            self.creationDate = creationDate
        }
    
}


func == (posting1: SCPosting, posting2: SCPosting) -> Bool {
    return posting1.id == posting2.id
}
