//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Eli Scherrer on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var realnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charactersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load user data
        APIManager.shared.getCurrentAccount { ( profile, err ) in
            if let profile = profile {
                self.profileImage.af_setImage(withURL: profile.profileUrl!)
                
                self.realnameLabel.text = profile.name
                self.usernameLabel.text = "@" + profile.screenname
                
            }
        }
        
        tweetTextView.delegate = self
    
    }

    func textViewDidChange(_ tweetTextView: UITextView) {
        let tweetLength = 140 - tweetTextView.text.count
        charactersLabel.text = "Characters Remaining: \(tweetLength)"
    }
    
    
    @IBAction func didTapPost(_ sender: UIBarButtonItem) {
        let tweetLength = 140 - tweetTextView.text.count
        
        if (tweetLength >= 0 && tweetLength < 140) {
            APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else {
                    self.performSegue(withIdentifier: "returnHome", sender: nil)
                    print("Compose Tweet Success!")
                }
            }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
