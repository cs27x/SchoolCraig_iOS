//
//  SCCategory.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation

enum SCCategory: String {
    // These are temporary categories, may change
    // later.
    
    case Electronics = "c2d268aa-71ad-44c1-bd9b-14d9c56f2431"
    
    case Kitchen = "bd1eb589-f3d6-47c0-92f4-777a5934f610"
    
    func toString() -> String {
        switch self {
        case .Electronics:
            return "Electronics"
        case .Kitchen:
            return "Kitchen"
        default:
            fatalError("Unknown Category type for toString method")
        }
    }


}