//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 27/02/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    

    
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var numRetweets: UILabel!
    
    @IBOutlet weak var numFav: UILabel!
    
    @IBOutlet weak var retweetImageView: UIImageView!
    
    @IBOutlet weak var favImageView: UIImageView!
    
    var tweet : Tweet!{
       didSet{
        tweetLabel.text = tweet.text as String!
        numRetweets.text = "\(tweet.retweetCount)"
        numFav.text = "\(tweet.favoritesCount)"
        
            //let dateFormatter = DateFormatter()
             //dateFormatter.dateFormat = "EEE MMM d HH:mm"
             //dateFormatter.dateFormat = "dd/MM/yy"
            //let date = dateFormatter.string(from: tweet.timeStamp as! Date ) as String!
            //print("date: \(date!)")
             //timeStampLabel.text = date!
        
        let timePassed = Int(Date().timeIntervalSince(tweet.timeStamp! as Date))
        let time = convertTime(numSeconds: timePassed)
        timeStampLabel.text = time
        
        
        if(tweet.favorited)!{
        self.favImageView.image = UIImage(named: "favor-icon-red")
        }
        else
        {
            self.favImageView.image = UIImage(named: "favor-icon")
        }
        
        if(tweet.retweeted!)
        {self.retweetImageView.image = UIImage(named: "retweet-icon-green")
        }
        else
        {
            self.retweetImageView.image = UIImage(named: "retweet-icon")
        }
        nameLabel.text = tweet.name as String!
        if tweet.imageUrl != nil {
            //print(tweet.imageUrl!)
            let fileUrl = URL(string: tweet.imageUrl! as String)
            thumbView.setImageWith(fileUrl!)
        }
        usernameLabel.text = "@" + (tweet.screenName! as String)
        }
    }
    
    func convertTime(numSeconds: Int) -> String
    {
        var time : String?
        if (numSeconds/60 < 60){
        time = "\(numSeconds/60) m"
            
        }
        else if(numSeconds/60 < 3600)
        {
            time = "\(numSeconds/3600) m"
        }
        else
        {
            time = "\(numSeconds/(24*60*60)) d"
        }
        
        return time!
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func retweetButton(_ sender: Any) {
     
        TwitterClient.sharedInstance?.retweet(id: self.tweet.id_str!, success: { (response: Tweet) in
            
           self.retweetImageView.image = UIImage(named: "retweet-icon-green")
            self.numRetweets.text = "\(response.retweetCount)"
            self.tweet.retweetCount = response.retweetCount
            self.tweet.retweeted = true
        }, faliure: { (error: Error) in
            
            TwitterClient.sharedInstance?.unretweet(id: self.tweet.id_str!, success: { (response: Tweet) in
                self.retweetImageView.image = UIImage(named: "retweet-icon")
                self.numRetweets.text = "\(response.retweetCount-1)"
                self.tweet.retweetCount = response.retweetCount
                self.tweet.retweeted = false
                print("unretweeted")
            }, faliure: { (error: Error) in
                //NOTHING TO BE IMPLEMENTED
            })
        })
        
    }
    
    
    @IBAction func favButton(_ sender: Any) {
        
        
        TwitterClient.sharedInstance?.favorite(id: tweet.id_str!, success: { (response: Tweet) in
            self.favImageView.image = UIImage(named: "favor-icon-red")
            self.numFav.text = "\(response.favoritesCount)"
            self.tweet.favoritesCount = response.favoritesCount
            self.tweet.favorited = response.favorited
        }, faliure: { (error: Error) in
            
            TwitterClient.sharedInstance?.unfavorite(id: self.tweet.id_str!, success: { (response: Tweet) in
                self.favImageView.image = UIImage(named: "favor-icon")
                self.numFav.text = "\(response.favoritesCount-1)"
                self.tweet.favoritesCount = response.favoritesCount
                self.tweet.favorited = response.favorited
            }, faliure: { (error: Error) in
                //NOTHING TO BE IMPLEMENTED
            })
        })
    }

}
