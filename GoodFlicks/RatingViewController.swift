//
//  RatingViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/4/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Mixpanel

class RatingViewController: UIViewController {
    
    @IBOutlet var imageView: UIView!
    @IBOutlet weak var askTitle: UILabel!
    
    @IBOutlet weak var askImage: PFImageView!
    
    @IBOutlet weak var numberRating: UITextField!
    
    @IBOutlet weak var comment: UITextField!
    
    
    var currentObject : PFObject?
    
    var id: String!
    var askId: String!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        // Unwrap the current object object
        if let object = currentObject {
            askTitle.text = object["Title"] as? String
            self.askId = object.objectId
            if let movieTitle = object["User"] as? PFObject {
                
                var query = PFQuery(className:"_User")
                var name: String!
                query.whereKey("objectId", equalTo: movieTitle.objectId!)
                query.findObjectsInBackgroundWithBlock{ ( asks: [AnyObject]?, error: NSError?)  in
                    if let obj = asks{
                        for names in obj{
                            
                            name = names.objectId
                        }
                        self.id = name
                    }
                }
                //var name: AnyObject? = capital.objectForKey("username")
            }
            
            //currencyCode.text = object["currencyCode"] as! String
            
            var initialThumbnail = UIImage(named: "question")
            askImage.image = initialThumbnail
            if let thumbnail = object["imageFile"] as? PFFile {
                askImage.file = thumbnail
                askImage.loadInBackground()
            }
        }
    }
    
    @IBAction func submitClicked(sender: AnyObject) {
        
        var postACL = PFACL()
        var posts = PFObject(className: "Rating")
        var ask = PFObject(className: "Ask")
        println(id)
        ask.objectId = self.askId
        
        posts["Rating"] = numberRating.text
        posts["Comment"] = comment.text
        posts["Rater"] = PFUser.currentUser()!
        posts["Ask"] = ask
        ask["Rated"] = true
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
    
}

