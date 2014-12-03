//
//  SCPostingDetailViewController.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 12/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

class SCPostingDetailViewController: UIViewController {
	
	@IBOutlet var posterInfoLabel: UILabel!
	@IBOutlet var descriptionLabel: UILabel!
	@IBOutlet var priceLabel: UILabel!
	@IBOutlet var titleLabel: UILabel!
	
	var post : SCPosting!
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		priceLabel.text = "$\(self.post.price)0"
		posterInfoLabel.text = "\(self.post.author.email)"
		descriptionLabel.text = self.post.details
		titleLabel.text = self.post.title
	}
	
}