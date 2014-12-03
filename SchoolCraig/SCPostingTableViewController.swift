//
//  SCPostingTableViewController.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 10/31/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

class SCPostingTableViewController: UIViewController, UITableViewDelegate {
	@IBOutlet
	var tableView: UITableView!
	
	var datasource: SCPostingTableViewDataSource?
	
	required init(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		var reuseIdentifier = "SCPostingTableViewCell"
		
		//self.tableView.registerClass(SCPostingTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
		
		var nipName=UINib(nibName: "SCPostingTableViewCell", bundle:nil)
		self.tableView.registerNib(nipName, forCellReuseIdentifier: reuseIdentifier)
		
		tableView.delegate = self
		self.datasource = SCPostingTableViewDataSource(cellIdentifier: reuseIdentifier)
		tableView.dataSource = self.datasource
	
		
	}
	
	func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		var post = self.datasource!.items[indexPath.row] as SCPosting
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("PostingDetailView") as SCPostingDetailViewController
		vc.post = post
		self.navigationController?.pushViewController(vc, animated: true)
		self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
	
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 150
	}
}