//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 27/02/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text : NSString?
    var timeStamp : NSDate?
    var retweetCount : Int = 0
    var favoritesCount : Int = 0
    var imageUrl : NSString?
    var name : NSString?
    var screenName : NSString?
    
    init (dictionary : NSDictionary){
        
        
        text = dictionary["text"] as! NSString?
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int ) ?? 0
        
        var dict: NSDictionary
        dict = (dictionary["user"] as! NSDictionary?)!
        //print (dict)
        imageUrl = (dict["profile_image_url_https"] as! NSString?)!
        name = dict["name"] as! NSString?
        screenName = dict["screen_name"] as! NSString?
        
        //print(dictionary)
        //print("Screen name: \(screenName)")
        
        //print("imageUrl: \(imageUrl! as String!)")
        //print("name: \(name)")
        
        let timestampString = dictionary["created_at"] as? String
        
        let formatter = DateFormatter()
        
        if let timestampString = timestampString{
            
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timeStamp = formatter.date(from: timestampString) as NSDate?
            
            //print("time stamp: \(timestampString)")
        }
        
        
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [NSObject]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary) as! NSObject
            tweets.append(tweet)
        }
        
        return tweets as! [Tweet]
    }

    
    
    
}
