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
    
    @IBAction func didRetweet(_ sender: Any) {
        
        if let tweet = self.tweet {
            if tweet.retweeted == false {
                tweet.retweeted = true
                APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                    if let  error = error {
                        print("Error retweeting tweet: \(error.localizedDescription)")
                        tweet?.retweeted = true
                        
                    } else if let tweet = tweet {
                        print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                        tweet.retweetCount += 1
                        tweet.retweeted = true
                    }
                }
            } else {
                tweet.retweeted = false
                
                APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                    if let  error = error {
                        print("Error unretweeting tweet: \(error.localizedDescription)")
                        tweet?.retweeted = false
                        
                    } else if let tweet = tweet {
                        print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                        tweet.retweetCount -= 1
                        tweet.retweeted = false
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func didFavorite(_ sender: Any) {

        if let tweet = self.tweet {
            if tweet.favorited! == false {
                tweet.favorited = true
                
                APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                    if let  error = error {
                        print("Error favoriting tweet: \(error.localizedDescription)")
                        tweet?.favorited = true
                        
                    } else if let tweet = tweet {
                        print("Successfully favorited the following Tweet: \n\(tweet.text)")
                        tweet.favoriteCount! += 1
                        //tweet.favorited = true
                        tweet.favorited = true
                    }
                }
            } else {
                tweet.favorited = false
                
                APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                    if let  error = error {
                        print("Error unfavoriting tweet: \(error.localizedDescription)")
                        tweet?.favorited = false
                        
                    } else if let tweet = tweet {
                        print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                        tweet.favoriteCount! -= 1
                        tweet.favorited = false
                    }
                }
            }
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
