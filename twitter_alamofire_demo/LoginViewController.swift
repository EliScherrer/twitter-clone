//
//  LoginViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 4/4/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//setup video -> https://www.youtube.com/watch?v=4VQQTLybods&feature=youtu.be&list=PLrT2tZ9JRrf7W4hoXt0cWHcvLRfvQlCKl
//twitter app manager - https://apps.twitter.com/app/14770163/show


import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogin(_ sender: Any) {
        APIManager.shared.login(success: {
            print("login was successful")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (error) in
            if let error = error {
                print("login failed")
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
