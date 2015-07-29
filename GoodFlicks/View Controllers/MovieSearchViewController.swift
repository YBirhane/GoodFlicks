//
//  MovieSearchViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 7/27/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
   // Movie Searching properties
    @IBOutlet weak var movieSearchBar: UISearchBar!
    var movieTitle: String?
    let api = TMDbAPI()
    
    //Movie properties 
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resourrces that can be recreated.
    }
    
  
}



extension MovieSearchViewController: UISearchBarDelegate {
        
        func movieSearchBarTextDidBeginEditing(movieSearchBar: UISearchBar){
            movieSearchBar.setShowsCancelButton(true, animated: true)
           
        }
        
        func movieSearchBarCancelButtonClicked(movieSearchBar: UISearchBar) {
            movieSearchBar.resignFirstResponder()
            movieSearchBar.setShowsCancelButton(false, animated: true)
           
        }
    
        func searchBarSearchButtonClicked( searchBar: UISearchBar){
            var movie = "\(movieSearchBar.text)"
            var movieTitle = movie.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            api.setMovie(movieTitle!)
            api.loadMovies(nil)
        }
    
        func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
            
        
        }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


