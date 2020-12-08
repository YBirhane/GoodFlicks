//
//  TableTableViewController.swift
//  ParseTutorial
//
//  Created by Ian Bradbury on 05/02/2015.
//  Copyright (c) 2015 bizzi-body. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class NewsFeedTableViewController: PFQueryTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Ask"
        self.textKey = "createdAt"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        //tableView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Ask")
        query.whereKey("User", notEqualTo: PFUser.currentUser()!)
        query.orderByDescending("createdAt")
        return query
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("NFCell") as! NewsFeedTableViewCell!
        if cell == nil {
            cell = NewsFeedTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "NFCell")
        }

        // Extract values from the PFObject to display in the table cell
        if let nameEnglish = object?["Title"] as? String {
            cell.movieTitle.text = nameEnglish
        }
        
        if let capital = object?["User"] as? PFObject {
            
            var query = PFQuery(className:"_User")
            var name: String!
            query.whereKey("objectId", equalTo: capital.objectId!)
            query.findObjectsInBackgroundWithBlock{ ( asks: [AnyObject]?, error: NSError?)  in
                if let obj = asks{
                    for names in obj{
                        
                        name = names.username!
                    }
                    cell.userLabel.text = name
                }
            }
            //var name: AnyObject? = capital.objectForKey("username")
        }
        
        // Display flag image
        var initialThumbnail = UIImage(named: "question")
        cell.posterImage.image = initialThumbnail
        if let thumbnail = object?["imageFile"] as? PFFile {
            cell.posterImage.file = thumbnail
            cell.posterImage.loadInBackground()
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "Rate"){
            // Get the new view controller using [segue destinationViewController].
            var detailScene = segue.destinationViewController as! RatingViewController
        
            // Pass the selected object to the destination view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let row = Int(indexPath.row)
                detailScene.currentObject = objects?[row] as? PFObject
        }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let objectToDelete = objects?[indexPath.row] as! PFObject
            objectToDelete.deleteInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // Force a reload of the table - fetching fresh data from Parse platform
                    self.loadObjects()
                } else {
                    // There was a problem, check error.description
                }
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
