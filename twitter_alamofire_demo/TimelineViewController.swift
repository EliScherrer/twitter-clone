//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        //set up table view
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        //get initial data
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
            refreshControl.endRefreshing()
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
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    @IBAction func didRetweet(_ sender: Any) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets[indexPath!.row]
        
        
        if tweet.retweeted == false {
            self.tweets[indexPath!.row].retweeted = true
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    self.tweets[indexPath!.row].retweeted = true

                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.tweets[indexPath!.row].retweetCount += 1
                    self.tweets[indexPath!.row].retweeted = true
                    self.tableView.reloadData()
                }
            }
        } else {
            self.tweets[indexPath!.row].retweeted = false

            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                    self.tweets[indexPath!.row].retweeted = false

                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    self.tweets[indexPath!.row].retweetCount -= 1
                    self.tweets[indexPath!.row].retweeted = false
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    @IBAction func didFavorite(_ sender: Any) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets[indexPath!.row]
        
        print("fav status: \(tweet.favorited!)")
        
        if tweet.favorited! == false {
            self.tweets[indexPath!.row].favorited = true

            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                    self.tweets[indexPath!.row].favorited = true

                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.tweets[indexPath!.row].favoriteCount! += 1
                    //tweet.favorited = true
                    self.tweets[indexPath!.row].favorited = true
                    self.tableView.reloadData()
                }
            }
        } else {
            self.tweets[indexPath!.row].favorited = false

            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                    self.tweets[indexPath!.row].favorited = false

                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    self.tweets[indexPath!.row].favoriteCount! -= 1
                    self.tweets[indexPath!.row].favorited = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    

    
}
