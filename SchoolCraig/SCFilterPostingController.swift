//
//  SCFilterPostingController.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 12/3/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

protocol SCFilterPostingControllerDelegate {

    func cancelledFilterPostings(controller: SCFilterPostingController)

    func filteredPostingsWithArray(controller: SCFilterPostingController,
                                   postings: Array<SCPosting>) -> ()

}


class SCFilterPostingController: UITableViewController {

    let cellId = "filterCellId"

    var delegate: SCFilterPostingControllerDelegate?
    
    let categories = [SCCategory.Appliances, SCCategory.Electronics,
                      SCCategory.Furniture, SCCategory.General,
                      SCCategory.Other, SCCategory.Kitchen,
                      SCCategory.MusicalInstruments, SCCategory.Textbooks,
                      SCCategory.Tickets, SCCategory.Wanted, SCCategory.Vehicles]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Filter"
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        
        self.navigationItem.rightBarButtonItem =
                UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel,
                                target: self,
                                action: "didCancel")
    }

    
    func didCancel() {
        self.delegate?.cancelledFilterPostings(self)
    }
    
    
    // UITableViewDataSource and Delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section <= 1 {
            return 1
		} else {
            return countElements(categories)
        }
    }

    override func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell =
                    tableView.dequeueReusableCellWithIdentifier(cellId,
                                                                forIndexPath: indexPath) as UITableViewCell
        
        
        if indexPath.section == 0 {
			cell.textLabel!.text = "Remove All Filters"
		} else if indexPath.section == 1 {
			cell.textLabel!.text = "Only User's Posts"
		} else {
            cell.textLabel!.text = categories[indexPath.row].toString()
        }

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
			return "Clear Filters"
		} else if section == 1 {
			return "Filter"
		} else {
            return "By Categories"
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if indexPath.section == 0 {
			self.delegate?.filteredPostingsWithArray(self,
				postings: SCPostingStore.sharedInstance.allPosts())
		} else if indexPath.section == 1 {
            var user = SCUserStore.sharedInstance.current!
            self.delegate?.filteredPostingsWithArray(self,
                postings: SCPostingStore.sharedInstance.filterByUserId(user.id))
        }
        else {
            var category = categories[indexPath.row]
            self.delegate?.filteredPostingsWithArray(self,
                postings: SCPostingStore.sharedInstance.filterByCategory(category))
        }
    }
}
