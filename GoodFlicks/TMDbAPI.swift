//
//  TMDbAPI.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 7/27/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import Foundation

class TMDbAPI {
    
    
    var wrong: NSError?
    let key = "8efd149c02c12d7a81bc1d976668418e"
    var movieSearched: String?
    
    func setMovie(film: String){
       movieSearched = film
        
    }
    
func loadMovies(completion: ((AnyObject) -> Void)!){
        
    
    
       var url = NSURL(string: "http://api.themoviedb.org/3/search/movie?api_key=8efd149c02c12d7a81bc1d976668418e&query=" + movieSearched!)!
        

        
        let request = NSMutableURLRequest(URL: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
            
        /*var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &self.wrong) as! NSDictionary*/
        
            
            if error != nil {
                // Handle error...
                return
            }
            
            
            
            println(error)
            println(response)
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
    task.resume()
        
}
    
   
}