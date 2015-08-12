//
//  RatingViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/4/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

class RatingViewController: UIViewController {

   
    @IBOutlet weak var askTitle: UILabel!
    
    @IBOutlet weak var askImage: UIImageView!
    
    @IBOutlet weak var numberRating: UITextField!
    
    @IBOutlet var imageView: UIView!
    @IBOutlet weak var comment: UITextField!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    var askTitleText: String!
    var askImageImage: UIImage!
    var id: String!
    var askId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        askTitle.text = askTitleText
        askImage.image = askImageImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitClicked(sender: AnyObject) {
        
        var postACL = PFACL()
        var posts = PFObject(className: "Rating")
        var ask = PFObject(className: "Ask")
        ask.objectId = askId
        
        posts["Rating"] = numberRating.text
        posts["Comment"] = comment.text
        posts["Rater"] = PFUser.currentUser()!
        posts["Ask"] = ask
        postACL.setReadAccess(true, forUserId: id)
        posts.ACL = postACL
        
        posts.saveInBackground()
        
        mixpanel.track("Answered user's question and clicked")
        performSegueWithIdentifier("home", sender: self)
    }
    
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent?) {
        if let touch = touches.first {
           self.view.endEditing(true)
        }
        super.touchesBegan(touches, withEvent:event!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
