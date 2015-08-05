//
//  MovieAskTableViewCell.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/3/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit

class MovieAskTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIButton!

    @IBOutlet weak var askFriendLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }

    @IBAction func checkboxClicked(sender: AnyObject) {
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
