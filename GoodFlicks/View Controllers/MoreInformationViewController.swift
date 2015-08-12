//
//  MoreInformationViewController.swift
//  GoodFlicks
//
//  Created by Yeabtsega Birhane on 8/2/15.
//  Copyright (c) 2015 Yeabtsega Birhane. All rights reserved.
//

import UIKit
import Mixpanel
class MoreInformationViewController: UIViewController {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet var infoView: UIView!
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    var movieTitleText = String()
    var moviePosterImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         infoView.backgroundColor = UIColor(patternImage: UIImage(named: "MaskCopy.png")!)
        movieTitle.text = movieTitleText
        moviePoster.image = moviePosterImage
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickMovieTitle(title: UILabel){
        movieTitle = title
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destViewController: MovieAskViewController = segue.destinationViewController as! MovieAskViewController
        
        destViewController.movieTitleText = movieTitleText
        destViewController.moviePosterImage = moviePosterImage
    }
      
    
    /*
    func pickMoviePoster(image: UIImage){
    
    }*/
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    }
    */


}
