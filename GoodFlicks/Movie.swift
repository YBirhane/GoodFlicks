//
//  Movie.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 7/27/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import Foundation

class Movie{
    
   var id: Int!
    var summary: String!
    var posterImage: String!
    //var posterImageData : NSData?
    
    init(id: Int, summary: String, posterImage:String){
        self.id = id
        self.summary = summary
        self.posterImage = posterImage
    }
    
    func toJSON() -> String {
        return ""
    }

}
