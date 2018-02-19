//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Eli Scherrer on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var coverPhotoImage: UIImageView!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentUser: User?
    var tweets: [Tweet] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load user data
        APIManager.shared.getCurrentAccount { ( profile, err ) in 
            if let profile = profile {
                self.currentUser = profile
                
                self.coverPhotoImage.af_setImage(withURL: profile.backgroundUrl!)
                self.profilePictureImage.af_setImage(withURL: profile.profileUrl!)
                
                self.realNameLabel.text = profile.name
                self.usernameLabel.text = "@" + profile.screenname
                self.taglineLabel.text = profile.tagline!
                
                self.tweetCountLabel.text = "Tweets: \(profile.tweetsCount!)"
                self.followerCountLabel.text = "Followers: \(profile.followersCount!)"
                self.followingCountLabel.text = "Following: \(profile.friendsCount!)"

                
            }
        }
        
        //set up table view
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 0.5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //get data
        APIManager.shared.getUserTimeLine() { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
