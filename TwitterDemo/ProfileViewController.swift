//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 02/03/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit
import AFNetworking
class ProfileViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var numTweetsLabel: UILabel!
    
    
    @IBOutlet weak var numFollowerLabel: UILabel!
    
    @IBOutlet weak var numFollowingLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if User.currentUser != nil{
        backgroundImageView.setImageWith(User.currentUser!.backgroundImageUrl! as! URL)
            profileImageView.setImageWith(User.currentUser!.profileUrl! as! URL)
           nameLabel.text = (User.currentUser!.name! as String!)
           usernameLabel.text = "@\((User.currentUser!.screenname! as String!)!)"
            numTweetsLabel.text="\(User.currentUser!.numTweets!)"
        numFollowerLabel.text = "\(User.currentUser!.numFollowers!)"
           numFollowingLabel.text = "\(User.currentUser!.numFollowing!)"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
