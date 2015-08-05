//
//  SearchedMoviesViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/2/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit

class SearchedMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // what's entered in the searchBar
    var searchTerm:String!
    var moreInfoLabel: String!
    var moreInfoPic: UIImage!
    // store results from Flickr in an array
    
    var TMDbResults: NSMutableArray! = NSMutableArray()
    var TMDbTitles: NSMutableArray! = NSMutableArray()
    // data that will load the image
    var imageData: NSData!
    var image:UIImage!
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
                    
                    self.TMDbResults = moviePoster
                    self.TMDbTitles = movieTitle
                    self.collectionView.reloadData()
                    
                })
            }
        })
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.TMDbResults.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cellSelected = collectionView.cellForItemAtIndexPath(indexPath) as! SearchedMoviesCollectionViewCell
        
        // capture title of selected cell
        moreInfoLabel = cellSelected.label.text!
        moreInfoPic = cellSelected.imageURL
        println(moreInfoLabel)
        //create an instance of the view controlle
        
        performSegueWithIdentifier("moreInfo", sender: self)
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destViewController: MoreInformationViewController = segue.destinationViewController as! MoreInformationViewController
        
        destViewController.movieTitleText = moreInfoLabel
        destViewController.moviePosterImage = moreInfoPic
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:SearchedMoviesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as! SearchedMoviesCollectionViewCell
        
        cell.image = UIImage(named: "NoPoster.png")
        
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            
            var error:NSError?
            
            //pointer to flickr results
            
            var searchURL: String = self.TMDbResults.objectAtIndex(indexPath.item) as! String
            var movieTitle: String = self.TMDbTitles.objectAtIndex(indexPath.item) as! String
            
            cell.label.text = movieTitle
            if  searchURL == "http://image.tmdb.org/t/p/w300/nil"{
                //cell.image = UIImage(named: "NoPoster.png")
            }
                
            else{
                
                self.imageData = NSData(contentsOfURL: NSURL(string: searchURL)!, options: nil, error: &error)!
                
                // if there is no error download synchronously to display on UI
                if error == nil{
                    self.image = UIImage(data: self.imageData)!
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.image = self.image
                        cell.imageURL = self.image
                        let yOffset: CGFloat = ((collectionView.contentOffset.y - cell.frame.origin.y)/200) * 25
                        cell.imageOffset = CGPointMake(0, yOffset)
                        
                    })
                    
                }
            }
        })
        
        
        
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        /*for view in collectionView.visibleCells(){
        var view: FlickrCollectionViewCell = view as! FlickrCollectionViewCell
        let yOffset: CGFloat = collectionView.contentOffset.y - view.frame.origin.y)
        }*/
        
    }

    
    
    
}
