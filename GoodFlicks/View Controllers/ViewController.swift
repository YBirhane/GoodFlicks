//
//  ViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 7/20/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//


import UIKit
import Parse
import ParseUI

class ViewController: UIViewController,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var logInViewController: PFLogInViewController? = PFLogInViewController()
    var signUpViewController: PFSignUpViewController? = PFSignUpViewController()
    
//    var allowLossyConversion: Bool = false
//    
//    let json = JSON(data: dataFromNetworking)
//        let json = JSON(jsonObject)
//    
//  let dataFromString = jsonString.dataUsingEncoding
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*    if (NSUTF8StringEncoding, allowLossyConversion) {
            let json = JSON(data: dataFromString)
    }*/

                
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        if(PFUser.currentUser() == nil){
            self.logInViewController!.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton
            
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "Yeabtsega Software"
            
            self.logInViewController!.logInView!.logo = logInLogoTitle
            
            self.logInViewController!.delegate = self
            
            var signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Yeabtsega Software"
            
            self.signUpViewController!.signUpView!.logo  = signUpLogoTitle
            self.signUpViewController!.delegate = self
            self.logInViewController!.signUpController = self.signUpViewController
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Parse Login
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username:String, password: String)->Bool{
        
        if(!username.isEmpty || !password.isEmpty){
            return true
        }
        else{
            return false
        }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?){
        println("Failed to login")
        
    }
    
    //Parse Sign Up
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion:nil)
        
    }
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up...")
        
    }
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController){
        println("User dismissed sign up.")
    }
    
    //Mark: Actions
    

    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("logout", sender: self)
    }
    
 
    
}

