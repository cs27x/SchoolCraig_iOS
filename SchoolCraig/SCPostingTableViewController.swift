//
//  SCPostingTableViewController.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 10/31/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

class SCPostingTableViewController: UIViewController, UITableViewDelegate, SCFilterPostingControllerDelegate, SCPostingDetailControllerDelegate  {
	@IBOutlet
	var tableView: UITableView!
	
	var datasource: SCPostingTableViewDataSource?
	

	required init(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		var reuseIdentifier = "SCPostingTableViewCell"
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshView:", name:"DatasourceUpdated", object: nil)
		
		var nipName=UINib(nibName: "SCPostingTableViewCell", bundle:nil)
		self.tableView.registerNib(nipName, forCellReuseIdentifier: reuseIdentifier)
		
		tableView.delegate = self
		self.datasource = SCPostingTableViewDataSource.sharedInstance
		tableView.dataSource = self.datasource
		
		let myFirstButton = UIButton()
		myFirstButton.setTitle("Filter", forState: .Normal)
		myFirstButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		myFirstButton.frame = CGRectMake(0, 0, 300, 30)
		myFirstButton.addTarget(self, action: "filterPressed:", forControlEvents: .TouchUpInside)

		self.tableView.tableHeaderView = myFirstButton
	
		
	}
	
	func filterPressed(sender: UIButton!) {
		var filterViewController = SCFilterPostingController()
		filterViewController.delegate = self
		var navController = UINavigationController(rootViewController: filterViewController)
		self.presentViewController(navController, animated: true, completion: nil)
	}
	
	func refreshView(notification: NSNotification){
		self.tableView.reloadData()
	}
	
	func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		var post = self.datasource!.items[indexPath.row] as SCPosting
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("PostingDetailView") as SCPostingDetailViewController
		vc.post = post
        vc.delegate = self
		self.navigationController?.pushViewController(vc, animated: true)
		self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
	
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 150
	}
	
	func cancelledFilterPostings(controller: SCFilterPostingController) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func filteredPostingsWithArray(controller: SCFilterPostingController, postings: Array<SCPosting>) -> () {
		self.datasource!.updateDatasourceWithItems(postings)
        self.dismissViewControllerAnimated(true, completion: nil)
	}
	
    func didDeletePosting(controller: SCPostingDetailViewController) {
        tableView.reloadData()
        var controller = self.navigationController!.popViewControllerAnimated(true)
   }
}

