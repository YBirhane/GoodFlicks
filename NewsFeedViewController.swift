//
//  NewsFeedViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/4/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import Mixpanel
class NewsFeedViewController: UIViewController   {


  /*  @IBOutlet weak var tableView: UITableView!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    // Retrieve's Asks title and image and username
    var movieTitle: String!
    var moreInfoPic: UIImage!
    var titles = [String]()
    var posterImages = [UIImage]()
    var pfposterImages = [PFFile]()
    var askerUsername = [String]()
    var asks = [AnyObject]()
    //Id of ask user is responding to
    var userID = [String]()
    
    //ID of ask ID
    var askID = [String]()
    
    //ID of Cell's Ask's User
    var cellID : String!
  
    // ID of Cell's Ask
    var cellAskID: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        self.getAsks()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
        // Dispose of any resources that can be recreated.
    }

   

    
    func getAsks(){
        var query = PFQuery(className: "Ask")
        query.whereKey("User", notEqualTo: PFUser.currentUser()!)
        query.orderByDescending("createdAt")

        query.findObjectsInBackgroundWithBlock{ (asks: [AnyObject]?, error: NSError?)  in
            if let obj = asks{
                self.asks = obj
                println(self.asks.count)
                println(self.asks)
                for ask in self.asks{
                   //println("here")
                    var user = ask["User"] as! PFObject
                    
                    
                    var askIdentification = ask as! PFObject
                    
                    // retrieving movie title from Ask and poster image
                    self.titles.append(ask["Title"] as! String)
                    
                    self.askID.append(askIdentification.objectId!)
                    
                  
                    
                    
                    let picture = ask["imageFile"] as! PFFile
                   
                        
                    picture.getDataInBackgroundWithBlock({ (data, error) -> Void in
                            //self.tableView.reloadData()
                            var image = UIImage(data: data!)
                            
                                                        //self.tableView.reloadData()
                        
                            
                            
                            self.posterImages.append(image!)
                            
                            
                       
                        
                            
                            
                        })
                    


                    
                    var queryUserId = ask["User"] as! PFObject
                    self.userID.append(queryUserId.objectId!)
            
                    
                
                    self.tableView.reloadData()
                }
            }
            
            self.getUsers(self.userID)

        }
        
      
    }
   
    func getUsers(UsersID: [String]){
  
       
        for identifications in UsersID{
        var userQuery : PFQuery = PFQuery(className: "_User")
        userQuery.whereKey("objectId", equalTo:identifications)
            userQuery.findObjectsInBackgroundWithBlock{ (users: [AnyObject]?, error: NSError?)  in
                if let obj = users{
                    //println(users!.count)
                    for user in obj{
                        
                        self.askerUsername.append(user["username"] as! String)
                       

                    }
                    

                }
            
              self.tableView.reloadData()
            }
    
          
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Rate"){
        var destViewController: RatingViewController = segue.destinationViewController as! RatingViewController
        
        destViewController.askTitleText = self.movieTitle
        
        // sets the pointer for the rating to be for the ask user is responding to
        
        destViewController.askImageImage = self.moreInfoPic
        destViewController.id = cellID
        
        destViewController.askId = cellAskID
        }
     
    }


    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            
            
               let cell:NewsFeedTableViewCell = tableView.dequeueReusableCellWithIdentifier("NFCell") as! NewsFeedTableViewCell
            if  titles.count  == posterImages.count && titles.count == askerUsername.count{
                
                cell.movieTitle.text = titles[indexPath.row]
                
                cell.posterImage.image = posterImages[indexPath.row]
                cell.userLabel.text = askerUsername[indexPath.row]
                
            }

            
            return cell
    }
    
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            if  titles.count  == posterImages.count && titles.count == askerUsername.count{
                
                return userID.count
            }
              else{
                //self.tableView.reloadData()
                return 0
            }
        }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let cell:NewsFeedTableViewCell = tableView.dequeueReusableCellWithIdentifier("NFCell") as! NewsFeedTableViewCell

        //self.movieTitle = cell.movieTitle.text
//        self.cellID = userID[indexPath.row]
//        self.cellAskID = askID[indexPath.row]
//        self.moreInfoPic = posterImages[indexPath.row]
      //self.performSegueWithIdentifier("Rate", sender: self)
//        mixpanel.track("Selected to see Asked Movie")
    }
    
*/

}
