//
//  SCNetworkStore.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCNetworkStore: SCNetworkStoreProtocol {
   
    var rootPath = "https://school-craig.herokuapp.com"
    
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
    
    
    func isAcceptableResponseCode(statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 400
    }
    
    
    func handleRequest<T: SCNetworkRequest>(request: T) {
        // Submit the request here.
        
        // TODO (brendan): why is NSURL evaluating to an optional?
        var url = NSURL(string: self.rootPath + request.path)
        var urlRequest = NSMutableURLRequest(URL: url!)
        
        urlRequest.HTTPMethod = request.method.rawValue
        
        // Convert data in url request and add from dictionary to data
        // Add HttpBody property
        if let body = request.body() {
            var httpData =
            NSJSONSerialization.dataWithJSONObject(body,
                options: NSJSONWritingOptions.allZeros,
                error: nil)
            
            urlRequest.HTTPBody = httpData
        }
        
        var requestHandler = {(data: NSData!, response: NSURLResponse!, error:NSError!) -> () in
            
            if let _error = error {
                request.onError!(_error)
                return
            }
            
            var httpResponse = response as NSHTTPURLResponse
            if !self.isAcceptableResponseCode(httpResponse.statusCode) {
                // Better error here!
                request.onError!(NSError())
                return
            }
            
            
            else {
                var jsonError: NSError?
                var json: AnyObject? =
                NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: &jsonError)
                
                // Check if there was an error parsing the json.
                if let _jsonError = jsonError {
                    request.onError!(_jsonError)
                }
                    // Check if the json optional is empty
                else if let _json: AnyObject = json {
                    // Check if this is an array of objects.
                    if let arr = _json as? NSArray {
                        var objects = request.parseArray(arr)
                        
                        self.onMainQueue {
                            request.onSuccess!(objects)
                        }
                    }
                    else {
                        var object = request.parse(json!)
                        self.onMainQueue {
                            request.onSuccess!([object])
                        }
                    }
                }
                    // The json optional was empty, so handle this.
                else {
                    request.onError!(NSError())
                }
                
            }
        }
        
        var error: NSError
        var task =
        NSURLSession.sharedSession().dataTaskWithRequest(urlRequest,
            completionHandler: requestHandler)
        
        task.resume()

    }


    func onMainQueue(exp: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            exp()
        })
    }
    
    
}
