//
//  SearchViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/2/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Mixpanel
class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet var myView: UIView!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
   
    var step: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        // Enables keyboard immediately
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Code for image animation when the user is typing
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        // clears searchBar when x is clicked
        
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        performSegueWithIdentifier("searchMovies", sender: self)
        mixpanel.track("Search for Movies Button Clicked")
    }
    
    // Gets text from SearchBar and sends it to GalleryViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController: SearchedMoviesViewController = segue.destinationViewController as! SearchedMoviesViewController
        
        // check if search Bar has words if not give error alert
        if !searchBar.text.isEmpty{
            
            destinationViewController.searchTerm = searchBar.text
            
        }
        else{
            let alert: UIAlertController = UIAlertController(title: "OOOOOPS"
                , message: "Please enter a search term" ,preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction( UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches, withEvent:event!)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     override func viewWillAppear(animated: Bool) {
      searchBar.text = ""
    }

    

}
