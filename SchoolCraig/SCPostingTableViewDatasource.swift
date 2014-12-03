//
//  SCPostingTableViewDatasource.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 10/31/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

public class SCPostingTableViewDataSource: NSObject, UITableViewDataSource {
	
	var items:[AnyObject]
	var cellIdentifier: String
	
	init(cellIdentifier: String!) {
		
		self.cellIdentifier = cellIdentifier
		self.items = []
		super.init()
		self.items = getAllPosts()
	
	}
	
	public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:SCPostingTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? SCPostingTableViewCell
		
		if (cell == nil)
		{
			print("Not initialized")
			//cell = SCPostingTableViewCell(style: UITableViewCellStyle.Custom, reuseIdentifier: cellIdentifier)
		}
		
		var post = items[indexPath.row] as SCPosting
		
		cell!.updateCellWithPost(post)

		return cell!
	}
	
	public func getAllPosts() -> NSArray {
		
		var postsArray:[SCPosting] = []

		var network = SCLocalNetworkStore(waitTimeInSeconds: 0)
		var store = SCPostingStore(network: network)
		
		var callbackCalled = false
		var success = {() -> () in
			postsArray = store.allPosts()
		}
		
		var error = {(var error: NSError) -> () in
			print(error)
		}
		
		store.fetchPosts(success: success, error: error)
		
		return postsArray
	}
	
}