//
//  SCCategory.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation

enum SCCategory: Int {
    // These are temporary categories, may change
    // later.
    
    case Kitchen = 0

    case Dorm = 1
    
    func toString() -> String {
        switch self {
        case .Kitchen:
            return "Kitchen"
        case .Dorm:
            return "Dorm"
        default:
            fatalError("Unknown Category type for toString method")
        }
    }


}