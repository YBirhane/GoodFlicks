//
//  TMDbHelper.swift
//  
//
//  Created by Yeabtsega Birhane on 8/2/15.
//
//

import UIKit

class TMDbHelper: NSObject {
    
    // returns JSON information
    class func URLForSearchString (searchString:String!) -> String{
        let apiKey:String = "8efd149c02c12d7a81bc1d976668418e"
        let search:String = searchString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        
        return "http://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(search)"
    }
    
    // downloads actual image
    
    class func URLForPosterPhoto(movie: Movie) -> String{
        
        
        return "http://image.tmdb.org/t/p/w300\(movie.poster)"
        
    }
    
    
    
    func searchForString(searchStr:String, completion:(searchString:String!, moviePoster:NSMutableArray!, movieTitle: NSMutableArray!, error:NSError!)->()){
        
        let searchURL:String = TMDbHelper.URLForSearchString(searchStr)
        let queue:dispatch_queue_t  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, {
            var error:NSError?
            
            let searchResultString:String! = String(contentsOfURL: NSURL(string: searchURL)!, encoding: NSUTF8StringEncoding, error: &error)
            
            if error != nil{
                completion(searchString: searchStr, moviePoster: nil, movieTitle: nil, error: error)
            }else{
                
                
                // Parse JSON Response
                
                let jsonData:NSData! = searchResultString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                
                // dictionary where we store all the json the api returns
                let resultDict:NSDictionary! = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as! NSDictionary
                
                
                if error != nil{
                    println("error")
                    completion(searchString: searchStr, moviePoster: nil,movieTitle:nil, error: error)
                }else{
                    
                    //                    let status:String! = resultDict.objectForKey("stat") as! String
                    //
                    //                    if status == "fail"{
                    //
                    //                        let messageString:String = resultDict.objectForKey("message") as! String
                    //                        let error:NSError? = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:messageString])
                    //
                    //
                    //                        completion(searchString: searchStr, moviePoster: nil, error:error )
                    //                    }
                    // Show structure of result
                    
                    let resultArray: NSArray = resultDict.objectForKey("results") as! NSArray
                    
                    let moviePoster:NSMutableArray = NSMutableArray()
                    
                    let movieTitle: NSMutableArray = NSMutableArray()
                    for posterObject in resultArray{
                        
                        let posterDict:NSDictionary = posterObject as! NSDictionary
                        println(posterDict)
                        var movie:Movie = Movie()
                        
                        
                        movie.title = posterDict.objectForKey("original_title") as! String
                        movie.summary = posterDict.objectForKey("overview") as! String
                        
                        // if poster path is nill set it to No movie poster
                        
                        if posterDict["poster_path"] is NSNull{
                            movie.poster = "/nil"
                        }
                            
                        else{
                            movie.poster = posterDict.objectForKey("poster_path") as! String
                        }
                        
                        let searchURL:NSString = TMDbHelper.URLForPosterPhoto(movie)
                        
                        
                        // allows us to download images asynchronously for each cell in our collection view
                        moviePoster.addObject(searchURL)
                        movieTitle.addObject(movie.title)
                        
                        
                    }
                    
                    completion(searchString: searchURL, moviePoster: moviePoster, movieTitle: movieTitle, error: nil)
                    
                    
                    
                }
                
                
                
                
                
            }
            
            
            
            
            
        })
    }
    
    

   
}
