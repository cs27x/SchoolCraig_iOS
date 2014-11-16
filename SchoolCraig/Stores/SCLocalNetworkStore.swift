//
//  SCLocalNetworkStore.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCLocalNetworkStore: SCNetworkStoreProtocol {
   
    var waitTimeInSeconds: UInt64
    
    var resultHash: Dictionary<String, AnyObject>?
    
    var callHash = Dictionary<String, Array<SCNetworkMethod>>()
    
    
    init(waitTimeInSeconds: UInt64) {
        self.waitTimeInSeconds = waitTimeInSeconds
    }
    
    
    func handleRequest<T: SCNetworkRequest>(request: T) {
        if waitTimeInSeconds > 0 {
            var time = dispatch_time(DISPATCH_TIME_NOW, Int64(waitTimeInSeconds * NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                self.executeRequest(request)
            }
        }
        else {
            executeRequest(request)
        }
    }
    
    
    func executeRequest<T: SCNetworkRequest>(request: T) {
        var fileName = request.path.substringFromIndex(advance(request.path.startIndex, 1))
        fileName =
            fileName.stringByReplacingOccurrencesOfString("/",
                                                          withString: ".",
                                                          options: NSStringCompareOptions.LiteralSearch,
                                                          range: nil)
        
        var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        
        // Record that this method was called.
        if let methods = callHash[request.path] {
            if !contains(methods, request.method) {
                callHash[request.path] = methods + [request.method]
            }
        }
        else {
            callHash[request.path] = [request.method]
        }
        
        switch request.method {
        case .GET:
            if let _path = path {
                var dataAtPath = NSData(contentsOfFile: _path)
                // TODO (brendan): Don't force unwrap the dataAtPath value.
                var serializedData =
                NSJSONSerialization.JSONObjectWithData(dataAtPath!, options: nil, error: nil) as NSDictionary?
                
                if let _data = serializedData {
                    
                    if let jsonArray = _data["data"] as? NSArray {
                        // The data field is an array.
                        request.onSuccess!(request.parseArray(jsonArray))
                    }
                    else if let jsonObj = _data["data"] as? NSDictionary {
                        // The data field is a dictionary.
                        request.onSuccess!([request.parse(jsonObj)])
                    }
                    else {
                        // Unrecognized object type at root.
                        // TODO (brendan): Better error message.
                        request.onError!(NSError())
                    }
                }
                else {
                    // The file is in invalid format to be read as a json
                    // file.
                    // TODO (brendan): Better error message.
                    request.onError!(NSError())
                }
            }
            else {
                // TODO (brendan): Populate error information.
                // Invalid fileName variable, the request is not formatted correctly
                // or a file has not been set up to handle the request.
                request.onError!(NSError())
            }
        case .POST:
            fallthrough
        case .PUT:
            fallthrough
        case .DELETE:
            // Successful completion of the request.
            // Not fetching any data.
            request.onSuccess!(nil)
        }
    }

    // TEST METHODS
    
    func didCall(#endpoint: String, method: SCNetworkMethod) -> Bool {
        if let methods = callHash[endpoint] {
            return contains(methods, method)
        }
        else {
            return false
        }
    }

}
