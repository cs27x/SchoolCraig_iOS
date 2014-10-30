//
//  SCNetworkStoreProtocol.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation

protocol SCNetworkStoreProtocol {
    
    func handleRequest<T: SCNetworkRequest>(request: T)
    
}