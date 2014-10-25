//
//  SCNetworkStore.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCNetworkStore {
   
    var rootPath = "blah.com"
    
    class var sharedInstance: SCNetworkStore {
        get {
            struct Static {
                static var instance : SCNetworkStore? = nil
                static var token : dispatch_once_t = 0
            }
            dispatch_once(&Static.token) { Static.instance = SCNetworkStore() }
            return Static.instance!
        }
    }
    
    
    func handleRequest<T>(request: SCNetworkRequest<T>) {
        // Submit the request here.

        var url = NSURL(string: self.rootPath + request.path)
        var urlRequest = NSMutableURLRequest(URL: url)

        urlRequest.HTTPMethod = request.method
        

        var requestHandler = {(data: NSData!, response: NSURLResponse!, error:NSError!) -> () in
            if let _error = error {
                request.onError!(_error)
            }
            else {
                var json: AnyObject? =
                    NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
                
                var objects = request.parseJsonObject(json!)
                request.onSuccess!(objects)

            }
        }
        
        NSURLSession.sharedSession().dataTaskWithRequest(urlRequest,
                                                         completionHandler: requestHandler)
    }

    
}
