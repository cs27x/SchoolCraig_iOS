//
//  SCLoginViewController.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 11/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation
import UIKit

class SCLoginViewController: UIViewController {

	@IBOutlet var usernameField: UITextField!
	@IBOutlet var loginButton: UIButton!
	@IBOutlet var passwordField: UITextField!
	
	var isValidLogin: Bool
	
	required init(coder aDecoder: NSCoder) {
		isValidLogin = false
		super.init(coder: aDecoder)
	}
	
	@IBAction func loginPressed(sender: UIButton) {
		isValidLogin = validateInput()
		
		if(isValidLogin) {
		
			sender.userInteractionEnabled = false;
			sender.setTitle("Logging in....", forState: .Normal)
			
			var store = SCUserStore.sharedInstance
			
			var success = {() -> () in
				
				if((store.current) != nil) {
					self.performSegueWithIdentifier("LoggedIn", sender: self)
					sender.userInteractionEnabled = true
					sender.setTitle("LOGIN", forState: .Normal)
					self.usernameField.text = ""
					self.passwordField.text = ""
				} else {
					var alertView = UIAlertView()
					alertView.addButtonWithTitle("OK")
					alertView.title = "Login Failed"
					alertView.message = "No account found. Please register."
					alertView.show()
				}
				
			}
			var error = {(var error: NSError) -> () in
				sender.userInteractionEnabled = true
				sender.setTitle("LOGIN", forState: .Normal)
				
				var alertView = UIAlertView()
				alertView.addButtonWithTitle("OK")
				alertView.title = "Login Failed"
				alertView.message = "Could not log in at this time. Please try again later."
				alertView.show()
			}
			
			store.login(email: usernameField.text, password: passwordField.text,
				success: success, error: error)
			
//			uncomment to skip to the posting screen
	//		self.performSegueWithIdentifier("LoggedIn", sender: self)
		}
	}
	
	func validateInput() -> Bool {
	
		var success = true
		
		if(usernameField.text == "" || passwordField.text == "") {
			var alertView = UIAlertView()
			alertView.addButtonWithTitle("OK")
			alertView.title = "Invalid Credentials"
			alertView.message = "Please ensure your username and password are correct."
			alertView.show()
			success = false
		} else if (!isValidEmail(usernameField.text)) {
			var alertView = UIAlertView()
			alertView.addButtonWithTitle("OK")
			alertView.title = "Invalid Email"
			alertView.message = "Please enter a valid email address."
			alertView.show()
			success = false
		}
		
		return success
	}
	
	func isValidEmail(checkString:NSString)->Bool
	{
		var emailRegex = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
		var emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)!;
		return emailTest.evaluateWithObject(checkString);
	}
}