//
//  CustomLoginViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 7/20/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse

class CustomLogInViewController: UIViewController {
    
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
    
    @IBAction func loginAction(sender: AnyObject) {
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        
        if(count(self.usernameField.text) <  4 || count(self.usernameField.text) < 5) {
            
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and Password must be greater than 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
            
        else{
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) ->
                Void in
                
                self.actInd.stopAnimating()
                
                if((user) != nil) {
                    
                    //var alert = UIAlertView(title: "Success", message: "Logged in", delegate: self, cancelButtonTitle: "OK")
                    //alert.show()
                    //let TabBarViewController =
                    self.performSegueWithIdentifier("login", sender: self)
                }
                else{
                    var alert = UIAlertView(title: "Error", message: "Incorrect Username of Password", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }
                
            })
            
        }
    }
    
    @IBAction func signupAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("signup", sender: self)
    }
    
    
    
    
    
}
