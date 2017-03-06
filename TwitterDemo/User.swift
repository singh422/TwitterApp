//
//  User.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 27/02/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : NSString?
    var screenname : NSString?
    var profileUrl : NSURL?
    var tagline : NSString?
    var dictionary : NSDictionary?
    var backgroundImageUrl : NSURL?
    var numTweets : Int?
    var numFollowers : Int?
    var numFollowing : Int?
    
    
    
    static let userDidLogOutNotification = "UserDidLogout"
    
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["screen_name"] as? String as NSString?
        print("******************")
        print(dictionary)
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            
            profileUrl = NSURL(string: profileUrlString)
        }
        
        //let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        let backgroundUrlString = dictionary["profile_banner_url"] as? String
        
        if let backgroundUrlString = backgroundUrlString {
            print(backgroundUrlString)
            backgroundImageUrl = NSURL(string: backgroundUrlString)
        }
        
        tagline = dictionary["description"] as? String as NSString?
        numTweets = dictionary["statuses_count"] as? Int
        numFollowers = dictionary["followers_count"] as? Int
        numFollowing = dictionary["friends_count"] as? Int
        
        
        tagline = dictionary["description"] as? String as NSString?
        
    }
    
    static var _currentUser : User?
    
    
    class var currentUser : User? {
    
        get{
            
            if _currentUser == nil {
            //let defaults = UserDefaults.standard
            let defaults = UserDefaults.standard
                
            let userData = defaults.object(forKey: "currentUserData") as? NSData
            if let userData = userData{
                //let dictionary = try JSONSerialization.data(withJSONObject: userData, options: []) as! NSDictionary
                
                let dictionary = try? JSONSerialization.jsonObject(with: userData as Data, options: []) as!NSDictionary
                if dictionary != nil{
                _currentUser = User(dictionary: dictionary!)
                    
                }
            }
                
            }
            return _currentUser
        }
        
        set(user){
            _currentUser = user
             let defaults = UserDefaults.standard
           if let user = user{
            
                let data =  try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
            defaults.set(data, forKey: "currentUserData")
            }
            else{
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }

}
