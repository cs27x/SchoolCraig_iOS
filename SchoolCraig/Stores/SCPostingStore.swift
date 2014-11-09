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
            print("NEXT WAS CALLED")
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
    
    var posts: Dictionary<String, SCPosting> = Dictionary<String, SCPosting>()
    
    init(network: SCNetworkStoreProtocol) {
        self.network = network
    }
    
    
    func fetchPosts(#success: (Array<SCPosting>) -> (), error: (NSError) -> ()) {
        // TODO: Implement me!
        // Use AllPostings request to get all the posts

        // Merge the posts that were retrieved by SCPostings into
        // the existing dictionary of posts.
        // If an error occurs, call the error callback.
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
    
    
    func createPost(#success: () -> (), error: () -> ()) {
        // TODO: Implement me!
    }
    
    
    internal func generate() -> SCPostingGenerator {
        print("GENERATING\n")
        print("\([SCPosting](posts.values))\n")
        return SCPostingGenerator(items: [SCPosting] (posts.values))
    }
    
    
}
