//
//  SCPostingDetailViewController.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 12/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

protocol SCPostingDetailControllerDelegate {

    func didDeletePosting(controller: SCPostingDetailViewController)

}


class SCPostingDetailViewController: UIViewController, UIAlertViewDelegate {
	
	@IBOutlet var posterInfoLabel: UILabel!
	@IBOutlet var descriptionLabel: UILabel!
	@IBOutlet var priceLabel: UILabel!
	@IBOutlet var titleLabel: UILabel!
	
	var post : SCPosting!
	
    var delegate: SCPostingDetailControllerDelegate?
    
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		priceLabel.text = "$\(self.post.price)0"
		posterInfoLabel.text = "\(self.post.author.email)"
		descriptionLabel.text = self.post.details
		titleLabel.text = self.post.title
        
        // Allow deletion if the user posted this post.
        if post.author.id == SCUserStore.sharedInstance.current?.id {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deletePosting")
        }
        
	}
    
    func deletePosting() {
        var alert = UIAlertView(title: "Are you sure?", message: "Are you sure you would like to delete this post?", delegate: self, cancelButtonTitle: "NO", otherButtonTitles: "YES")
        alert.show()
    }
	
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if buttonIndex == 1 {
            // Wants to delete the post.
            var success = {() -> () in
                print("Deleted")
                self.delegate?.didDeletePosting(self)

            }
            
            var error = {(var error: NSError) -> () in
                var failAlert = UIAlertView(title: "Delete Failed", message: "There was an error when trying to delete this post. Please try again later.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
                failAlert.show()
            }
            
            SCPostingStore.sharedInstance.deletePosting(post, success: success, error: error)
        }
    }
}