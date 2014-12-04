//
//  AppDelegate.swift
//  SchoolCraig
//
//  Created by Brendan McNamra on 10/22/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var postsSuccess = {() -> () in
            print(SCPostingStore.sharedInstance.allPosts())
        }
        
        var postsError = {(var error: NSError) -> () in
            print(error)
        }
        
        var loginSuccess = {() -> () in
            
            var posting = SCPosting(id: "new",
                title: "Car",
                details: "I'm selling my car",
                author: SCUserStore.sharedInstance.current!,
                category: SCCategory.Vehicles,
                price: 1000000000,
                creationDate: NSDate())
            SCPostingStore.sharedInstance.createPost(posting, success: postsSuccess, error: postsError)
        }
        var loginError = {(var error: NSError) -> () in
            print(error)
        }
        
        SCUserStore.sharedInstance.login(email: "brendan.d.mcnamara@vanderbilt.edu",
                                         password: "password",
                                         success: loginSuccess,
                                         error: loginError)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

