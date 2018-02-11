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
    
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            
            retweetCountLabel.text = "\(tweet.retweetCount)"
            if tweet.retweeted == true {
                retweetImage.image = #imageLiteral(resourceName: "retweet-icon-green")
            }
            else {
                retweetImage.image = #imageLiteral(resourceName: "retweet-icon")
            }
            
            favoriteCountLabel.text = "\(tweet.favoriteCount ?? 0)"
            if tweet.favorited == true {
                favoriteImage.image = #imageLiteral(resourceName: "favor-icon-red")
            }
            else {
                favoriteImage.image = #imageLiteral(resourceName: "favor-icon")
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
