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
	
	@IBAction func loginPressed(sender: AnyObject) {
		isValidLogin = validateInput()
		
		var shouldSegue = false;
		
		if(isValidLogin) {
			var request = SCLoginRequest(email: usernameField.text, password: passwordField.text)
			
			request.onSuccess = {(var userArray) -> () in
				self.performSegueWithIdentifier("LoggedIn", sender: self)
				shouldSegue = true;
			}
			
			request.onError = {(var error) -> () in
				shouldSegue = false;
				var alertView = UIAlertView()
				alertView.addButtonWithTitle("OK")
				alertView.title = "Login Failed"
				alertView.message = "Could not log in at this time. Please try again later."
				alertView.show()
			}
			
			//TODO: Nonzero wait time
			var networkStore = SCLocalNetworkStore(waitTimeInSeconds: 2)
			networkStore.handleRequest(request)
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if (segue.identifier == "LoggedIn") {
			print("segue")
			
		}
	}
	
	override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
		
		return isValidLogin
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