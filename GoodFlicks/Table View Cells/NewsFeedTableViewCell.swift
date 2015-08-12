//
//  NewsFeedTableViewCell.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/4/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Mixpanel

class NewsFeedTableViewCell: UITableViewCell {
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
   @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
  
    
    @IBOutlet weak var askedAbout: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
