//
//  SCUserStore.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/9/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCUserStore: SequenceType {
    
    internal class SCUserGenerator: GeneratorType {
        
        var items: Array<SCUser>
        
        
        init(items: Array<SCUser>) {
            self.items = items
        }
        
        
        func next() -> SCUser? {
            if items.isEmpty {
                return nil
            }
            var el = items[0]
            if (countElements(items) > 1) {
                items = [] + items[1...(countElements(items) - 1)]
            }
            else {
                items = []
            }
            return el
        }
    }
    
    
    class var sharedInstance: SCUserStore {
        get {
            struct Static {
                static var instance : SCUserStore? = nil
                static var token : dispatch_once_t = 0
            }
            dispatch_once(&Static.token) {
                Static.instance = SCUserStore(network: SCNetworkStore.sharedInstance)
            }
            return Static.instance!
        }
    }

    
    var network: SCNetworkStoreProtocol
    
    var current: SCUser?
    
    private var users = Array<SCUser>()
    
    init(network: SCNetworkStoreProtocol) {
        self.network = network
    }
    
    
    func login(#email: String, password: String, success: () -> (), error: (NSError) -> ()) {
        // TODO: Implement me!
        
        // Use the login request.
        // Set the current user property.
        var request = SCLoginRequest(email: email,
                                     password: password)
        
        request.onSuccess = {(var userArray) -> () in
            if let _userArray = userArray {
                self.current = _userArray[0]
                
                // Append the current user to the users Array
                self.users.append(self.current!)
                
                // call the success callback
                success()
                
            }
            else {
                // call the failure callback
                error(NSError())
            }
        }
        
        request.onError = {(var errorObj) -> () in
            // call the failure callback
            error(errorObj)
        }
        
        // handle the request using the network store.
        self.network.handleRequest(request)
    }
    

    func createUser(#firstName: String,
                     lastName: String,
                     email: String,
                     password: String,
                     success: () -> (),
                     error: (NSError) -> ()) {

        // TODO: Implement me!
        
        // Use the create user request.
        var request = SCCreateUserRequest(firstName: firstName,
                                          lastName: lastName,
                                          email: email,
                                          password: password)
        
        request.onSuccess = {(var userArray) -> () in
            success()
        }
        
        request.onError = {(var errorObj) -> () in
            // call the failure callback
            error(errorObj)
        }
        
        // handle the request using the network store.
        self.network.handleRequest(request)
        
    }
    
    
    func add(user: SCUser) {
        if !contains(users, user) {
            users.append(user)
        }
    }
    
    
    func generate() -> SCUserGenerator {
        return SCUserGenerator(items: users)
    }

    
    func count() -> Int {
        return countElements(users)
    }
}
