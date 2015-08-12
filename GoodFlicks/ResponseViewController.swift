//
//  ResponseViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/5/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

class ResponseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    var askID: String!
    //var setAskID: String!
    
    // objectId of rater
    var raterId: [String] = []
    
    var responseMovieTitle: String!
    
    var responseMovieImage: UIImage!
    var comment: [String] = []
    var rating: [String] = []
    var posterImage: [UIImage] = []
    var responseUser: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = responseMovieTitle
        moviePoster.image = responseMovieImage
        
        tableView.dataSource = self
        tableView.delegate = self
        self.getRatings()
        
     
 
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            println(comment.count)
            println(responseUser.count)
            println(rating.count)
            let cell:ResponseTableViewCell = tableView.dequeueReusableCellWithIdentifier("RCell") as! ResponseTableViewCell
            cell.commentLabel.text = comment[indexPath.row]
            cell.usernameLabel.text = responseUser[indexPath.row]
            cell.rating.text = rating[indexPath.row]
            return cell
    }
    
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            if responseUser.count == comment.count{
                return responseUser.count
            }
            else{
                return 0
            }
            
    }


    func getRatings(){
        var myRatings = PFObject(withoutDataWithClassName: "Ask", objectId: askID)
        var query = PFQuery(className: "Rating")
        query.whereKey("Ask", equalTo: myRatings)
        query.findObjectsInBackgroundWithBlock{ (ratings: [AnyObject]?, error: NSError?)  in
            if let obj = ratings{
                
                for rate in obj{
                    
                    self.comment.append(rate["Comment"] as! String)
                    self.rating.append(rate["Rating"] as! String)
                    var rater = rate["Rater"] as! PFObject
                    self.raterId.append(rater.objectId!)
                    
                    
                  
                    
                }
            }
           
            self.getUser(self.raterId)
       
        }
    }
            
    
    func getUser(rates: [String]){
        
            for ids in rates{
           
            var query = PFQuery(className: "_User")
            query.whereKey("objectId", equalTo: ids)
            query.findObjectsInBackgroundWithBlock{ (ratings: [AnyObject]?, error: NSError?)  in
                if let obj = ratings{
                    
                    for rate in obj{
                    self.responseUser.append(rate["username"] as! String)
                    
                    
                        
                    }
                }
                println(self.responseUser.count)
                self.tableView.reloadData()
                }
            }
//        println("here4")
//        println(self.responseUser.count)
        //self.tableView.reloadData()
        
    }
    
    
    
}
