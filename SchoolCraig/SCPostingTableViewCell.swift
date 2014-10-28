//
//  SCPostingTableViewCell.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 10/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

class SCPostingTableViewCell : UITableViewCell {
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var priceLabel: UILabel!
	@IBOutlet var posterInfoLabel: UILabel!
	@IBOutlet var descriptionLabel: UILabel!
	
	func updateCell(post: SCPosting) {
		titleLabel.text = post.title
		priceLabel.text = "$ \(post.price)"
		//PosterInfoLabel = post.author.
		descriptionLabel.text = post.details
		
	}

}
