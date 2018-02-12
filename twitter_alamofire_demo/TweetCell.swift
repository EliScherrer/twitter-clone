//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
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
            userHandleLabel.text = tweet.user.screenname
            profilePicture.af_setImage(withURL: tweet.user.profileUrl!)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

    
    
    
}
