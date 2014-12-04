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
                Static.instance = SCPostingStore(network: SCNetworkStore.sharedInstance)
            }
            return Static.instance!
        }
    }
    
    var newPosts: Array<SCPosting> = []
    var posts: Dictionary<String, SCPosting> = Dictionary<String, SCPosting>()
    
    init(network: SCNetworkStoreProtocol) {
        self.network = network
    }
    
    
    func deletePosting(posting: SCPosting, success: () -> (), error: (NSError) -> ()) -> () {
        
        if let hashPosting = self.posts[posting.id] {
            var request = SCDeletePostingRequest(posting: posting)
            request.onSuccess = {(var arr) -> () in
                // Remove posting from the list.
                self.posts[posting.id] = nil
                success()
            }
            request.onError = {(var errorObj) -> () in
                error(errorObj)
            }
            self.network.handleRequest(request)
        }
        else {
            // Trying to delete a posting that is not in the store.
            error(NSError())
        }
    }
    
    
    func fetchPosts(#success: () -> (), error: (NSError) -> ()) {
        var request = SCAllPostingsRequest()
        
        request.onSuccess = {(var array: Array<SCPosting>?) -> () in
            // Remove any postings that are marked as new when fetching.
            // Clear the array of new posts.
            self.newPosts = []
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
            self.newPosts.append(posting)
            success()
        }

        
        request.onError = {(var errorMessage: NSError) -> () in
            error(errorMessage)
        }
        
        network.handleRequest(request)
    }
    
    
    func allPosts() -> Array<SCPosting> {
        var allPosts = (posts.values + newPosts)
        
        // Sort posts in reverse chronological ordering.
        allPosts.sort { (post1, post2) -> Bool in
            return post1.creationDate.compare(post2.creationDate) == NSComparisonResult.OrderedDescending
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
        // Note: This method assumes that you are adding
        // a post that is NOT new, meaning that it has an
        // id that is set from the ruby server.
        posts[post.id] = post
    }
    
    
    subscript(id: String) -> SCPosting? {
        // Check the list of new postings.
        for posting in self.newPosts {
            if posting.id == id {
                return posting
            }
        }
        return posts[id]
    }
    
    
    internal func generate() -> SCPostingGenerator {
        return SCPostingGenerator(items: [SCPosting] (allPosts()))
    }
    
    
}
