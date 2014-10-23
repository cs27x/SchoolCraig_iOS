//
//  SCDesignStore.swift
//  SchoolCraig
//
//  Created by Brendan McNamara on 10/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

enum SCDesignColorKey {
    case MainAppColor
    case SecondaryAppColor
    case WhiteColor
}


class SCDesignStore: NSObject {
    
    class func colorForKey(key: SCDesignColorKey) -> UIColor {
        switch (key) {
        case .MainAppColor:
            return UIColor(red: 74/255.0, green: 74/255.0, blue: 74/255.0, alpha: 1)
            
        case .SecondaryAppColor:
            return UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1)
            
        case .WhiteColor:
            return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
            
        }
    }
    
    
}

