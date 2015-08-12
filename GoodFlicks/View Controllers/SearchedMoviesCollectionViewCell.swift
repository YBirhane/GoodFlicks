//
//  SearchedMoviesCollectionViewCell.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/2/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Mixpanel

class SearchedMoviesCollectionViewCell: UICollectionViewCell {
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    
    var imageOffset: CGPoint!
    var imageURL: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
  /* var image: UIImage!{
        get{
            return self.image
        }
        set{
            self.imageView.image = newValue
            
            if imageOffset != nil{
                setImageOffset(imageOffset)
            }else{
                setImageOffset(CGPointMake(0,0))
            }
        }
        
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.image = UIImage(named: "NoImage.png")
        
        // Initialization code
    }
    override func prepareForReuse() {
        
        super.prepareForReuse()
        self.imageView.image = UIImage(named: "NoImage.png")
        
    }
    
    /*
    // Necessary initializer to set up Image View
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpImageView()
        
        
        label.textColor = UIColor(white: 0.45, alpha: 1.0)
        //label.font = UIFont(name: MegaTheme.fontName, size: 11)
        
        imageView.layer.borderColor = UIColor(white: 0.2, alpha: 1.0).CGColor
        imageView.layer.borderWidth = 0.5

    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setUpImageView()
    }
    
    // Sets up Image View for Images
    func setUpImageView(){
        self.clipsToBounds = true
        
        imageView = UIImageView(frame: CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 320, 200))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = false
        self.addSubview(imageView)
    }
    
    // makes sure the image isn't ugly
    func setImageOffset(imageOffset:CGPoint){
        
        self.imageOffset = imageOffset
        
        let frame: CGRect = imageView.bounds
        
        let offsetFrame: CGRect = CGRectOffset(frame, self.imageOffset.x, self.imageOffset.y)
        imageView.frame = offsetFrame
        
    }

    */
}
