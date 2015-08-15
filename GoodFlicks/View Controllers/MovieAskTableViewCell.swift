//
//  MovieAskTableViewCell.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/3/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

protocol MovieAskTableViewCellDelegate: class {
    func cell(cell: MovieAskTableViewCell, didSelectToAskUser user: PFUser)
    func cell(cell: MovieAskTableViewCell, didSelectToUnaskUser user: PFUser)
}


class MovieAskTableViewCell: UITableViewCell {

  let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    
    @IBOutlet weak var checkBoxImage: UIImageView!
    
    
    var isChecked: Bool {
        
        get {
            if self.checkBoxImage.image == UIImage(named: "CheckboxUnchecked-1.png") {
                return false
            } else {
                return true
            }
        }
        
        set {
            if newValue {
                self.checkBoxImage.image = UIImage(named: "CheckboxChecked.png")
            } else {
                self.checkBoxImage.image = UIImage(named: "CheckboxUnchecked-1.png")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxImage.image = UIImage(named: "CheckboxUnchecked-1.png")
        //self.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        // Initialization code
    }

   
    @IBOutlet weak var askFriendLabel: UILabel!
    
    weak var delegate: MovieAskTableViewCellDelegate?
    



}
