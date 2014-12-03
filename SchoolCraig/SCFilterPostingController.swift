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

    let categories = [SCCategory.Appliances, SCCategory.Electronics,
                      SCCategory.Furniture, SCCategory.General,
                      SCCategory.Other, SCCategory.Kitchen,
                      SCCategory.MusicalInstruments, SCCategory.Textbooks,
                      SCCategory.Tickets, SCCategory.Wanted, SCCategory.Vehicles]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Filter"
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        
    }


    // UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        else {
            return countElements(categories)
        }
    }

    override func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell =
                    tableView.dequeueReusableCellWithIdentifier(cellId,
                                                                forIndexPath: indexPath) as UITableViewCell
        
        
        cell.textLabel!.text = "Here is a cell"

        return cell
    }

}
