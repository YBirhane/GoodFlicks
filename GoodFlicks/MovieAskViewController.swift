//
//  MovieAskViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/2/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import Mixpanel
class MovieAskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet var askView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    // UI
    var movieTitleText = String()
    var moviePosterImage = UIImage()
    
    
    var checkedCellsSet = Set<NSIndexPath>()
    
    
    var username = "username"
    
    // Friends list and IDs retrieved from Parse
    var friendsList: [String] = []
    var friendsListID: [String!] = []

    // Users and Ids of friends User asks
    
    var selectedFriends: [String] = []
    var selectedFriendsID: [String] = []
   


    @IBAction func askButtonClicked(sender: AnyObject) {
        selectedFriendsID.append(PFUser.currentUser()!.objectId!)
        var postACL = PFACL()
        var posts = PFObject(className: "Ask")
        var imageData = UIImagePNGRepresentation(moviePoster.image)
        posts["imageFile"] = PFFile(data: imageData)
        posts["Title"] = movieTitle.text
        posts["User"] = PFUser.currentUser()!
        for user in selectedFriendsID {
           postACL.setWriteAccess(true, forUserId: user)
            postACL.setReadAccess(true, forUserId: user)
        }
        mixpanel.track("First Ask Button Clicked")
        posts.ACL = postACL
        posts.saveInBackground()
        performSegueWithIdentifier("backToSearch", sender: self)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        askView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
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
            //cell.user!.username = friendsList[indexPath.row]
            
            
//            cell.checkBoxImage.image = UIImage(named: "CheckboxUnchecked-1.png")
            
//            if self.checkedCellsSet.contains(indexPath) {
//                cell.checkBoxImage.image = UIImage(named: "CheckboxChecked.png")
//            }
            
            cell.isChecked = (self.checkedCellsSet.contains(indexPath))
            
            
            return cell
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            
            return friendsList.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var rowSelected = tableView.cellForRowAtIndexPath(indexPath) as! MovieAskTableViewCell

        
        if rowSelected.isChecked {
            self.checkedCellsSet.remove(indexPath)
            println(friendsListID[indexPath.row])
            removeObject(rowSelected.askFriendLabel.text! , fromArray: &selectedFriends)
            removeObject(friendsListID[indexPath.row], fromArray: &selectedFriendsID)
        } else {
            self.checkedCellsSet.insert(indexPath)
            selectedFriends.append(rowSelected.askFriendLabel.text!)
            selectedFriendsID.append(friendsListID[indexPath.row])
        }
        
        rowSelected.isChecked = !rowSelected.isChecked
        
//        if (rowSelected.checkBoxImage.image  == UIImage(named: "CheckboxChecked.png")){
//            
//            self.checkedCellsSet.remove(indexPath)
//            
//            println(friendsListID[indexPath.row])
//            removeObject(rowSelected.askFriendLabel.text! , fromArray: &selectedFriends)
//            removeObject(friendsListID[indexPath.row], fromArray: &selectedFriendsID)
//            rowSelected.checkBoxImage.image = UIImage(named: "CheckboxUnchecked-1.png")
//         }
//        
//        else{
//            
//            self.checkedCellsSet.insert(indexPath)
//        
//         rowSelected.checkBoxImage.image = UIImage(named: "CheckboxChecked.png")
//         selectedFriends.append(rowSelected.askFriendLabel.text!)
//         selectedFriendsID.append(friendsListID[indexPath.row])
//         println(selectedFriends)
//         println(selectedFriendsID)
//        }
    }

   
}

