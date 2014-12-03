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
    
    case Textbooks = "512f7c7c-9936-4325-b988-170e1e763f29"
    
    case Furniture = "73d7dffd-1000-4bf3-8b99-62292378bb25"
    
    case MusicalInstruments = "9d8cb0e9-db16-4a79-aee3-bd39962e3153"
    
    case Tickets = "58210af5-9694-4a19-9a7c-156ef004751e"
    
    case Appliances = "ad158dc7-e896-4b1c-ab94-c7e23685ed62"
    
    case Vehicles = "9d1961d2-a076-407d-affd-78172eb509e1"
    
    case Free = "2eb4c830-0dcb-49ba-9d01-1f5ca643084a"
    
    case General = "72752c26-6692-4b4c-9b26-9c2baadeff6f"
    
    case Other = "a6f48e64-433d-4a8c-bb1a-027c2217cb69"
    
    case Wanted = "e10f1569-0cf1-4c99-a9de-6f66f9fc38a6"
    
    func toString() -> String {
        switch self {
        case .Electronics:
            return "Electronics"
        case .Kitchen:
            return "Kitchen"
            
        case .Textbooks:
            return "Textbooks"
            
        case .Furniture:
            return "Furniture"
            
        case .MusicalInstruments:
            return "Musical Instruments"
        
        case .Tickets:
            return "Tickets"
            
        case .Appliances:
            return "Appliances"
        
        case .Vehicles:
            return "Vehicles"
            
        case .Free:
            return "Free"
            
        case .General:
            return "General"
            
        case .Other:
            return "Other"
            
        case .Wanted:
            return "Wanted"
        
        default:
            fatalError("Unknown Category type for toString method")
        }
    }


}