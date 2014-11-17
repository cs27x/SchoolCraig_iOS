//
//  SCNewPostViewController.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 11/17/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

class SCNewPostViewController: UIViewController {

	@IBOutlet var titleField: UITextField!
	@IBOutlet var descriptionField: UITextView!
	@IBOutlet var priceField: UITextField!


	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		descriptionField.layer.borderWidth = 1.0;
		descriptionField.layer.borderColor = UIColor.blackColor().CGColor
		
	}
	
	
	@IBAction func cancelPressed(sender: UIBarButtonItem) {
		self.dismissViewControllerAnimated(true, completion:nil)
		
	}
	@IBAction func submitPressed(sender: UIBarButtonItem) {
	
		var network = SCLocalNetworkStore(waitTimeInSeconds: 0)
		var userStore = SCUserStore(network: network)
		
		var postingStore = SCPostingStore(network: network)
		
		var title = titleField.text
		var details = descriptionField.text
		var price = NSString(string: priceField.text).doubleValue
		
		var posting = SCPosting(id: "123TODO",
			title: title,
			details: details,
			author: userStore.current!,
			category: SCCategory.Kitchen,
			price: price,
			creationDate: NSDate())
		
		var success = {() -> () in
			self.dismissViewControllerAnimated(true, completion:nil)
		}
		
		var error = {(var error: NSError) -> () in
			print(error)
			var alertView = UIAlertView()
			alertView.addButtonWithTitle("OK")
			alertView.title = "Posting Failed"
			alertView.message = "Please try again later."
			alertView.show()

		}
		
		postingStore.createPost(posting, success: success, error: error)
	}
}
