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
		
		var post = items[indexPath.row] as SCPosting;
		
		cell!.updateCellWithPost(post)

		return cell!
	}
	
	public func getAllPosts() -> NSArray {
		var request = SCAllPostingsRequest()
		var postsArray:[SCPosting] = []
		
		request.onSuccess = {(var array: Array<SCPosting>) -> () in
			postsArray = array
			//print(array)
		}
		
		request.onError = {(var error: NSError) -> () in
			print(error)
		}
		
		var networkStore = SCLocalNetworkStore(waitTimeInSeconds: 0)
		networkStore.handleRequest(request)
		
		return postsArray
	}
	
}