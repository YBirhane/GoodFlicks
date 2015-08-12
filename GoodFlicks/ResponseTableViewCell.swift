//
//  ResponseTableViewCell.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/5/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Mixpanel

class ResponseTableViewCell: UITableViewCell {
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
