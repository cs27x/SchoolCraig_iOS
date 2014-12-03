//
//  SCRegistrationViewController.swift
//  SchoolCraig
//
//  Created by Oliver Dormody on 11/17/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import Foundation//
import UIKit

class SCRegistrationViewController: UIViewController {
	
	@IBOutlet var emailField: UITextField!
	@IBOutlet var confirmPasswordField: UITextField!
	@IBOutlet var passwordField: UITextField!
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	@IBAction func submitPressed(sender: UIBarButtonItem) {
	
		if(validateInput()) {
			var network = SCLocalNetworkStore(waitTimeInSeconds: 0)
			var store = SCUserStore(network: network)
			
			var success = {() -> () in
				var alertView = UIAlertView()
				alertView.addButtonWithTitle("OK")
				alertView.title = "Registration Succeeded!"
				alertView.message = "Now, please log in."
				alertView.show()
				self.dismissViewControllerAnimated(true, completion:nil)
				
			}
			var error = {(var error: NSError) -> () in
				print(error)
				var alertView = UIAlertView()
				alertView.addButtonWithTitle("OK")
				alertView.title = "Registration Failed"
				alertView.message = "Please try again later."
				alertView.show()
			}
			
            // TODO: Fix this!
            store.createUser(firstName: "",
                             lastName: "",
                             email: emailField.text,
                             password: passwordField.text, success: success, error: error)
		}
	}
	
	@IBAction func cancelPressed(sender: UIBarButtonItem) {
		self.dismissViewControllerAnimated(true, completion:nil)
	}
	
	func isValidEmail(checkString:NSString)->Bool
	{
		var emailRegex = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
		var emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)!;
		return emailTest.evaluateWithObject(checkString);
	}
	
	func validateInput() -> Bool {
		
		var success = true
		
		if(emailField.text == "" || passwordField.text == "") {
			var alertView = UIAlertView()
			alertView.addButtonWithTitle("OK")
			alertView.title = "Invalid Credentials"
			alertView.message = "Please ensure you have filled out all fields."
			alertView.show()
			success = false
		} else if (!isValidEmail(emailField.text)) {
			var alertView = UIAlertView()
			alertView.addButtonWithTitle("OK")
			alertView.title = "Invalid Email"
			alertView.message = "Please enter a valid email address."
			alertView.show()
			success = false
		} else if (passwordField.text != confirmPasswordField.text) {
			var alertView = UIAlertView()
			alertView.addButtonWithTitle("OK")
			alertView.title = "Passwords don't match."
			alertView.message = "Please ensure you passwords match."
			alertView.show()
		}
		
		return success
	}

}
