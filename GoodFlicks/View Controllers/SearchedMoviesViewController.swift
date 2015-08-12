//
//  SearchedMoviesViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/2/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Mixpanel
class SearchedMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
 
    let mixpanel: Mixpanel = Mixpanel.sharedInstance() 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // what's entered in the searchBar
    var searchTerm:String!
    var moreInfoLabel: String!
    var moreInfoPic: UIImage!
    var movieTitle: String!
    // store results from Flickr in an array
    
    var TMDbResults: NSMutableArray! = NSMutableArray()
    var TMDbTitles: NSMutableArray! = NSMutableArray()
    // data that will load the image
    var imageData: NSData!
    var image:UIImage!
    
    var movieImages = [UIImage]()
    var movieTitles = [String]()
    var movieURLS = [String]()
    /*var movieTitles = self.TMDbTitles as AnyObject as [String]
    var swiftArray = self.TMDbResults as AnyObject as [String]*/

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        loadPosters()
  
    


    }
    
    // loads photos from Flickr
 func loadPosters(){
        // first create a Flickr object
        
        let TMDb: TMDbHelper = TMDbHelper()
        
        // takes input from searchBar and searches for it within the flickr object
        TMDb.searchForString(searchTerm, completion: { (searchString: String!, moviePoster: NSMutableArray!, movieTitle: NSMutableArray!, error: NSError?) -> () in
            
            // if there is no error load image on back thread
            if error == nil{
                dispatch_async(dispatch_get_main_queue(),{ () -> Void in
                    self.movieURLS = moviePoster as AnyObject as! [String]
                    self.movieTitles = movieTitle as AnyObject as! [String]
                    //self.TMDbResults = moviePoster
                    //self.TMDbTitles = movieTitle
                    self.reload()
                    
                })
            }
        })
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movieURLS.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var cellSelected = collectionView.cellForItemAtIndexPath(indexPath) as! SearchedMoviesCollectionViewCell
        
        // capture title of selected cell
        moreInfoLabel = cellSelected.label.text!
        moreInfoPic = cellSelected.imageView.image
       
        
       
        
        performSegueWithIdentifier("moreInfo", sender: self)
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destViewController: MoreInformationViewController = segue.destinationViewController as! MoreInformationViewController
        
        destViewController.movieTitleText = moreInfoLabel
        destViewController.moviePosterImage = moreInfoPic
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:SearchedMoviesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as! SearchedMoviesCollectionViewCell
        var error: NSError?
        
        if(error == nil){
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            //pointer to flickr results
            
            var searchURL = self.movieURLS[indexPath.row]
            self.movieTitle  = self.movieTitles[indexPath.row]
            
            if  searchURL == "http://image.tmdb.org/t/p/w300/nil"{
                cell.label.text = self.movieTitles[indexPath.row]
                self.movieImages.append(cell.imageView.image!)

            }
            
            else{
                self.imageData = NSData(contentsOfURL: NSURL(string: searchURL)!, options: nil, error: &error)!
                
                // if there is no error download synchronously to display on UI
                if error == nil{
                    self.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.movieURLS[indexPath.row])!, options: nil, error: &error)!)!
                   
                    dispatch_async(dispatch_get_main_queue(), {
                     
                         self.movieImages.append(self.image)
                         println(self.movieImages.count)
                         println(indexPath.row)
                        cell.imageView.image = self.image
                        cell.imageURL = self.image
                        cell.label.text = self.movieTitles[indexPath.row]
                        
                 
                        })
                    

               
            }
                else{
                    println("error")
                }
            }
        })
            
    }
            
        else{
            println("Error")
        }
      
        return cell
    }
    
 
    func reload (){
        self.collectionView.reloadData()
    }
    
   

    
    
    
}
