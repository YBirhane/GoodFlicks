//
//  MovieAskViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/2/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse

class MovieAskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    // UI
    var movieTitleText = String()
    var moviePosterImage = UIImage()
    
    
    var username = "username"
    
    // Friends list and IDs retrieved from Parse
    var friendsList: [String] = []
    var friendsListID: [String] = []

    // Users and Ids of friends User asks
    
    var selectedFriends: [String] = []
    var selectedFriendsID: [String] = []
   
   /* var groupMessage = PFObject(className:"Message")
    var groupACL = PFACL.ACL()
    
    // userList is an NSArray with the users we are sending this message to.
    for (user : PFUser in userList) {
    groupACL.setReadAccess(true, forUser:user)
    groupACL.setWriteAccess(true, forUser:user)
    }
    
    groupMessage.ACL = groupACL
    groupMessage.saveInBackground()
*/

    @IBAction func askButtonClicked(sender: AnyObject) {
        var postACL = PFACL()
        var posts = PFObject(className: "Ask")
        var imageData = UIImagePNGRepresentation(moviePoster.image)
        posts["imageFile"] = PFFile(data: imageData)
        posts["Title"] = movieTitle.text
        
        for user in selectedFriendsID {
           postACL.setWriteAccess(true, forUserId: user)
            postACL.setReadAccess(true, forUserId: user)
        }
        
        posts.ACL = postACL
        posts.saveInBackground()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        movieTitle.text = movieTitleText
        moviePoster.image = moviePosterImage
        tableView.delegate = self
        tableView.dataSource = self
        self.getFriends()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFriends(){
        
        var query = PFQuery(className: "Friends")
        query.whereKey("fromUser", equalTo: PFUser.currentUser()!)
        query.includeKey("toUser")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?)  in
            if let obj = objects{
            for object in obj {
                
                var lesson = object["toUser"] as! PFObject
                var friend: AnyObject = lesson[self.username]!
                var friendID  = lesson.objectId!
                
                self.friendsList.append(friend as! String)
                self.friendsListID.append(friendID as String)
                self.tableView.reloadData()
                
                }
                
            }
        }
        
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            
            let cell:MovieAskTableViewCell = tableView.dequeueReusableCellWithIdentifier("MovieAskCell") as! MovieAskTableViewCell
            
            cell.askFriendLabel.text = friendsList[indexPath.row]
            
            
            
            
            return cell
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            
            return friendsList.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var rowSelected = tableView.cellForRowAtIndexPath(indexPath) as! MovieAskTableViewCell

        selectedFriends.append(rowSelected.askFriendLabel.text!)
        selectedFriendsID.append(friendsListID[indexPath.row])
        println(selectedFriends)
        println(selectedFriendsID)
    }

   
}