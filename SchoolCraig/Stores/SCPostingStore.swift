//
//  PostingStore.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 11/6/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit


class SCPostingStore: SequenceType {
   
    
    internal class SCPostingGenerator: GeneratorType {
        
        private var items: Array<SCPosting>
        
        init(items: Array<SCPosting>) {
            self.items = items
        }
        
        
        func next() -> SCPosting? {
            if items.isEmpty {
                return nil
            }
            var el = items[0]
            if (countElements(items) <= 1) {
                items = []
            }
            else {
                items = [] + items[1...(countElements(items) - 1)]
            }
            return el
        }

    
    }
    
    private var network: SCNetworkStoreProtocol
    
    class var sharedInstance: SCPostingStore {
        get {
            struct Static {
                static var instance : SCPostingStore? = nil
                static var token : dispatch_once_t = 0
            }
            dispatch_once(&Static.token) {
                Static.instance = SCPostingStore(network: SCLocalNetworkStore(waitTimeInSeconds: 1))
            }
            return Static.instance!
        }
    }
    
    var posts: Dictionary<String, SCPosting> = Dictionary<String, SCPosting>()
    
    init(network: SCNetworkStoreProtocol) {
        self.network = network
    }
    
    
    func fetchPosts(#success: () -> (), error: (NSError) -> ()) {
        var request = SCAllPostingsRequest()
        
        request.onSuccess = {(var array: Array<SCPosting>?) -> () in
            for item in array! {
                self.add(item)
            }
            success()
        }

        request.onError = {(var errorMessage: NSError) -> () in
            error(errorMessage)
        }
        
        network.handleRequest(request)
    }
    

    func createPost(posting: SCPosting, success: () -> (), error: (NSError) -> ()) {
        var request = SCCreatePostingRequest(posting: posting)
        
        request.onSuccess = {(var array: Array<SCPosting>?) -> () in
            self.add(posting)
            success()
        }

        
        request.onError = {(var errorMessage: NSError) -> () in
            error(errorMessage)
        }
        
        network.handleRequest(request)
    }
    
    
    func allPosts() -> Array<SCPosting> {
        var allPosts = Array<SCPosting>()
        
        for (key, posting) in self.posts {
            allPosts.append(posting)
        }
        return allPosts
    }
    
    func filterByCategory(category: SCCategory) -> Array<SCPosting> {
        return self.allPosts().filter({(var posting) -> Bool in
            // Implement me!
            return posting.category==category
        })
    }
    
    
    func filterByUserId(string: String) -> Array<SCPosting> {
        return self.allPosts().filter({(var posting) -> Bool in
            // Implement me!
            return posting.author.id == string
        })
    }
    
    func count() -> Int {
        return countElements(posts)
    }
    
    
    func add(post: SCPosting) {
        posts[post.id] = post
    }
    
    
    subscript(id: String) -> SCPosting? {
        return posts[id]
    }
    
    
    internal func generate() -> SCPostingGenerator {
        return SCPostingGenerator(items: [SCPosting] (posts.values))
    }
    
    
}
