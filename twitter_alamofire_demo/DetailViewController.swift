//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Eli Scherrer on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            
            retweetCountLabel.text = "\(tweet.retweetCount)"
            if tweet.retweeted == true {
                retweetButton.setBackgroundImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            }
            else {
                retweetButton.setBackgroundImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            }
            
            favoriteCountLabel.text = "\(tweet.favoriteCount ?? 0)"
            if tweet.favorited == true {
                favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            }
            else {
                favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
                
            }
            
            userNameLabel.text = tweet.user.name
            userHandleLabel.text = "@" + tweet.user.screenname
            profilePicture.af_setImage(withURL: tweet.user.profileUrl!)

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
