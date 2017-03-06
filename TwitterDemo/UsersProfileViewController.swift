//
//  UsersProfileViewController.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 02/03/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class UsersProfileViewController: UIViewController {

    
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numTweetsLabel: UILabel!

    @IBOutlet weak var numFollowingLabel: UILabel!
    
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.setImageWith(user!.backgroundImageUrl! as! URL)
        
            profileImageView.setImageWith(user!.profileUrl! as! URL)
   
       
            nameLabel.text = user!.name! as String!
    
            
            usernameLabel.text = "@\((user?.screenname! as String!)!)"
        
        
            
            numTweetsLabel.text="\(user!.numTweets!)"
   
        
      
            numFollowersLabel.text = "\(user!.numFollowers!)"
   
        
            numFollowingLabel.text = "\(user!.numFollowing!)"
        
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
