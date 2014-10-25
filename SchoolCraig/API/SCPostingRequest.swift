//
//  SCPostingRequest.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

class SCPostingRequest<S>: SCNetworkRequest<SCPosting> {
    
    init() {
        super.init(method: "GET", path: "/path/to/postings")
    }

}
