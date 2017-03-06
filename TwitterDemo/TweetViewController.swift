//
//  TweetViewController.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 01/03/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favImageView: UIImageView!
    
    var tweet : Tweet?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let imageUrl = URL(string: (tweet!.imageUrl as String!))
        thumbView.setImageWith(imageUrl!)
        nameLabel.text = tweet!.name as String!
        usernameLabel.text = "@" + (tweet!.screenName! as! String)
        tweetLabel.text = tweet!.text as String!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d HH:mm"
        let date = dateFormatter.string(from: tweet!.timeStamp as! Date ) as String!
        timeLabel.text = date!
        numRetweetsLabel.text = "\(tweet!.retweetCount)"
        numFavoritesLabel.text = "\(tweet!.favoritesCount)"
        
        if(tweet!.favorited)!{
            self.favImageView.image = UIImage(named: "favor-icon-red")
        }
        else
        {
            self.favImageView.image = UIImage(named: "favor-icon")
        }
        
        if(tweet!.retweeted!)
        {self.retweetImageView.image = UIImage(named: "retweet-icon-green")
        }
        else
        {
            self.retweetImageView.image = UIImage(named: "retweet-icon")
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func retweetButton(_ sender: Any) {
        
        TwitterClient.sharedInstance?.retweet(id: (self.tweet?.id_str!)!, success: { (response: Tweet) in
            
            self.retweetImageView.image = UIImage(named: "retweet-icon-green")
            self.numRetweetsLabel.text = "\(response.retweetCount)"
            self.tweet!.retweetCount = response.retweetCount
            self.tweet!.retweeted = true
        }, faliure: { (error: Error) in
            
            TwitterClient.sharedInstance?.unretweet(id: (self.tweet?.id_str!)!, success: { (response: Tweet) in
                self.retweetImageView.image = UIImage(named: "retweet-icon")
                self.numRetweetsLabel.text = "\(response.retweetCount-1)"
                self.tweet!.retweetCount = response.retweetCount
                self.tweet!.retweeted = false
                print("unretweeted")
            }, faliure: { (error: Error) in
                //NOTHING TO BE IMPLEMENTED
            })
        })
        
    }
    
    

    @IBAction func favButton(_ sender: Any) {
        TwitterClient.sharedInstance?.favorite(id: tweet!.id_str!, success: { (response: Tweet) in
            self.favImageView.image = UIImage(named: "favor-icon-red")
            self.numFavoritesLabel.text = "\(response.favoritesCount)"
            self.tweet!.favoritesCount = response.favoritesCount
            self.tweet!.favorited = response.favorited
            //self.tweet!.favorited = true
        }, faliure: { (error: Error) in
            
            TwitterClient.sharedInstance?.unfavorite(id: self.tweet!.id_str!, success: { (response: Tweet) in
                self.favImageView.image = UIImage(named: "favor-icon")
                self.numFavoritesLabel.text = "\(response.favoritesCount-1)"
                self.tweet!.favoritesCount = response.favoritesCount
                self.tweet!.favorited = response.favorited
            }, faliure: { (error: Error) in
                //NOTHING TO BE IMPLEMENTED
            })
        })
    }
        

    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let replyViewController = segue.destination as! ReplyViewController
        replyViewController.tweet = self.tweet
    }
 

}
