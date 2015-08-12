//
//  AskAnsweredViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/5/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import Mixpanel
class AskAnsweredViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    @IBOutlet weak var tableView: UITableView!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    // Get the comment,rating, and movie information
    var askID = [String]()
    
    var comment = [String]()
    var rating = [String]()
    var askTitle = [String]()
    var askPoster = [UIImage]()
    
    // set the image and text of response movie user wants to see
    var responseTitle: String!
    var responseImage: UIImage!
    
    // movie Asker is seeing
    var reviewTitle: String!
    
    
    // number of replies
    
    var numberReplies: String!
    
    //id of ask user wants to see
    var id: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        self.getAnsweredAsks()
        //self.getImages()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

            let cell:AskAnsweredTableViewCell = tableView.dequeueReusableCellWithIdentifier("AACell") as! AskAnsweredTableViewCell
            
           
            
            cell.askAnsweredMovieTitle.text = askTitle[indexPath.row]
            cell.askAnsweredMoviePoster.image = askPoster[indexPath.row]
            
           // cell.numberOfReplies.text = String(askTitle.count)
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
            return cell
    }
    
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
           
            return askPoster.count

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        id = askID[indexPath.row]
        reviewTitle = askTitle[indexPath.row]
        responseImage = askPoster[indexPath.row]
        self.performSegueWithIdentifier("showRatings", sender: self)
        mixpanel.track("Selected to see responses to ask")
 
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destViewController: ResponseViewController = segue.destinationViewController as! ResponseViewController
        destViewController.askID = id
        destViewController.responseMovieTitle = reviewTitle
        destViewController.responseMovieImage = responseImage
    }


    
    func getAnsweredAsks(){
      
        var query = PFQuery(className: "Ask")
        query.whereKey("User", equalTo: PFUser.currentUser()!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock{ (asks: [AnyObject]?, error: NSError?)  in
            if let obj = asks{
                
                for ask in obj{
                self.askTitle.append(ask["Title"] as! String)
                                    
                var id = ask.objectId!
                self.askID.append(id as String!)
                self.tableView.reloadData()
                    
                let picture = ask["imageFile"] as! PFFile
                picture.getDataInBackgroundWithBlock({ (data, error) -> Void in
                      
                        var image = UIImage(data: data!)
                        self.askPoster.append(image!)
                        self.tableView.reloadData()
                        
                })

                }
            }
        }
    }
    
    
}


