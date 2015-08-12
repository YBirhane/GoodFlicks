//
//  AskAnsweredTableViewCell.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/5/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Mixpanel

class AskAnsweredTableViewCell: UITableViewCell {
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    @IBOutlet weak var askAnsweredMoviePoster: UIImageView!
    
    @IBOutlet weak var askAnsweredMovieTitle: UILabel!
    
   
    
    //@IBOutlet weak var numberOfReplies: UILabel!
    //var askMovieTitle: String!
    //var askMoviePoster: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
