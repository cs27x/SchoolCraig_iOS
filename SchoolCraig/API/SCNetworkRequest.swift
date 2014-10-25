//
//  SCAPIRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation

class SCNetworkRequest <T> {

    var method: String

    var path: String
    
    var onSuccess: ((Array<T>) -> ())?

    var onError: ((NSError) -> ())?
    
    init(method: String, path: String) {
        self.method = method
        self.path = path
    }
    
    
    func parseJsonObject(json: AnyObject) -> Array<T> {
        fatalError("parseJsonObject must be overridden.")
    }
    
}