//
//  CustomSignUpViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 7/20/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

class CustomSignUpViewController: UIViewController {
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.actInd.center = self.view.center
        
        self.actInd.hidesWhenStopped = true
        
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //Mark: Actions
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        mixpanel.track("CustomSignUp")
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        var email = self.emailField.text
        
        if(count(self.usernameField.text) <  4 || count(self.usernameField.text) < 5) {
            
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and Password must be greater than 5.", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        }
            
        else if (count(self.emailField.text) < 8){
            var alert = UIAlertView(title: "Invalid", message: "Please enter a valid email.", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        }
            
        else{
            self.actInd.startAnimating()
            
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                self.actInd.stopAnimating()
                
                if((error) != nil){
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    
                    alert.show()
                    
                }
                else{
                    self.performSegueWithIdentifier("signedUp", sender: self)
                    /*var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()*/
                    
                    //self.performSegueWithIdentifier("cancel", sender: self)
                }
            })
            
        }
        
        
        
    }
    
    
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches, withEvent:event!)
    }

}
