//
//  AskAnsweredTableViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/13/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class AskAnsweredTableViewController: PFQueryTableViewController {

    var movieTitle: String!
    var movieImage: UIImage!
    
   
        // Initialise the PFQueryTable tableview
        override init(style: UITableViewStyle, className: String!) {
                super.init(style: style, className: className)
        
            }
    
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
            query.whereKey("User", equalTo: PFUser.currentUser()!)
            query.orderByDescending("createdAt")
            return query
        }

    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("AACell") as! AskAnsweredTableViewCell!
        if cell == nil {
            cell = AskAnsweredTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AACell")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let nameEnglish = object?["Title"] as? String {
            cell.askAnsweredMovieTitle.text = nameEnglish
            self.movieTitle = nameEnglish
            
        }
        
        /*if let capital = object?["User"] as? PFObject {
            
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
        }*/
        
        // Display flag image
        var initialThumbnail = UIImage(named: "question")
        cell.askAnsweredMoviePoster.image = initialThumbnail
        self.movieImage = initialThumbnail
        if let thumbnail = object?["imageFile"] as? PFFile {
            
            cell.askAnsweredMoviePoster.file = thumbnail
            
            cell.askAnsweredMoviePoster.loadInBackground()
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showRatings"){
            // Get the new view controller using [segue destinationViewController].
            var detailScene = segue.destinationViewController as! ResponseViewController
            
            // Pass the selected object to the destination view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                //detailScene.moviePoster.image = self.movieImage
                //detailScene.movieTitleLabel.text = self.movieTitle
                let row = Int(indexPath.row)
                detailScene.currentObject = objects?[row] as? PFObject
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}


