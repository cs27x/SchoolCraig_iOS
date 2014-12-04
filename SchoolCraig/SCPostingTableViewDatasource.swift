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
	
	var items:[AnyObject] = []
	var cellIdentifier: String
	
	init(cellIdentifier: String!) {
		
		self.cellIdentifier = cellIdentifier
		super.init()
		getAllPosts()
	
	}
	
	class var sharedInstance: SCPostingTableViewDataSource {
		get {
			struct Static {
				static var instance : SCPostingTableViewDataSource? = nil
				static var token : dispatch_once_t = 0
			}
			dispatch_once(&Static.token) {
				Static.instance = SCPostingTableViewDataSource(cellIdentifier: "SCPostingTableViewCell")
			}
			return Static.instance!
		}
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
	
	public func getAllPosts() {
		
		var postsArray:[SCPosting] = []

		var store = SCPostingStore.sharedInstance
		
		var callbackCalled = false
		var success = {() -> () in
			self.items = store.allPosts()
			NSNotificationCenter.defaultCenter().postNotificationName("DatasourceUpdated", object: nil)
		}
		
		var error = {(var error: NSError) -> () in
			print(error)
		}
		
		store.fetchPosts(success: success, error: error)		
	}
	
	public func updateDatasourceWithItems(items: NSArray) {
		self.items = items
		NSNotificationCenter.defaultCenter().postNotificationName("DatasourceUpdated", object: nil)
	}
	
}