//
//  AppDelegate.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 7/20/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import Mixpanel
@UIApplicationMain
class AppDelegate: UIResponder , UIApplicationDelegate{
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("iLzubsq0ShR5lpWoNMex8YFpuuejArNcZOLiUWnE", clientKey: "6K21KpbepZ92aRhahkoDbfMkrQFhLX4O3fy8g48Q")
        //PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
                
        
        Mixpanel.sharedInstanceWithToken("705a7d944ea3c340f2a86075f8449dc9")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("App launched")
     
        var user = PFUser.currentUser()
        var storyboard = UIStoryboard(name: "Main1", bundle: nil)

  
        

        
        if (user != nil) {
            // 3
            // if we have a user, set the TabBarController to be the initial View Controller
            
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
           
        } else {
            // 4
            // Otherwise set the LoginViewController to be the first
            
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            let loginViewController = CustomLogInViewController()
            
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("LogInView") as! UIViewController
            
            self.window?.rootViewController = initialViewController
            
            self.window?.makeKeyAndVisible()
        }
       
        return true
    }
    
    /*func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }*/
    
    func applicationDidBecomeActive(application: UIApplication) {
     
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
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
}

