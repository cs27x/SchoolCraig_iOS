//
//  SCAPIRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation

protocol SCNetworkRequest {
    
    typealias T
    
    var method: SCNetworkMethod { get }
    
    var path: String { get }
    
    var onSuccess: ((Array<T>?) -> ())? { get set }
    
    var onError: ((NSError) -> ())? { get set }
    
    // JSON -> Object
    func parse(json: AnyObject) -> T
    func parseArray(json: NSArray) -> Array<T>
    
    // Object -> JSON
    func serialize(object: T) -> AnyObject
    func serializeArray(objects: Array<T>) -> NSArray
    
}