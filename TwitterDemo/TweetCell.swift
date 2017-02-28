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
    
    
    var tweet : Tweet!{
       didSet{
        tweetLabel.text = tweet.text as String!
        
            let dateFormatter = DateFormatter()
             //dateFormatter.dateFormat = "EEE MMM d HH:mm"
             dateFormatter.dateFormat = "dd/MM/yy"
            let date = dateFormatter.string(from: tweet.timeStamp as! Date ) as String!
            print("date: \(date!)")
            timeStampLabel.text = date!
        
        nameLabel.text = tweet.name as String!
        if tweet.imageUrl != nil {
            print(tweet.imageUrl!)
            let fileUrl = URL(string: tweet.imageUrl! as String)
            thumbView.setImageWith(fileUrl!)
        }
        usernameLabel.text = "@" + (tweet.screenName! as String)
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
