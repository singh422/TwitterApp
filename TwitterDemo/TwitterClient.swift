//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 27/02/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?

    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey:
        "5Il3up1kWS1vgPa5D3dSxLOHh", consumerSecret: "RvnAJUBpAMdoCzvjslAfSBp2o76d8Oafug66ejNYMerx5TmUym")
    
    
    func login(success:@escaping () -> (), failure:@escaping (NSError) -> () ){
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance!.deauthorize()
        TwitterClient.sharedInstance!.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?)-> Void in
            //print("I got a token")
            
            if requestToken != nil {
                
                if requestToken!.token != nil {
                    print(requestToken!.token)
                    var tok = requestToken!.token as! String
                    let url = NSURL(string : "https://api.twitter.com/oauth/authorize?oauth_token=\(tok)") as! URL
                    UIApplication.shared.openURL(url)
                }
                    
                else {
                }
            }
            else{}
            
        },failure: { (error: Error?) -> Void in
            print("error:\(error!.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogOutNotification), object: nil)
        
        //NotificationCenter.defaultCenter.post(name: NSNotification.Name(rawValue: "userDidLogout"), object: nil)
    }
    
    func homeTimeline(success: @escaping ([Tweet])-> (), failure: @escaping (NSError) -> ()){
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response : Any?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            
            success(tweets)
            
            /*for tweet in tweets {
                print("\(tweet.text!)")
            }*/
            
        }, failure: { (task: URLSessionDataTask?, error: Error!) in
            failure(error as NSError)
           // print("error\(error.localizedDescription)")
        })
        

    
    }

    func currentAccount(success: @escaping (User) -> (), failure:@escaping (NSError) ->()){
    
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task : URLSessionDataTask, response : Any?) in
            //print("account \(response!)")
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            //print("user\(user)")
            
            //print("Name: \(user.name)")
            //print("Screenname: \(user.screenname)")
            //print("ProfileURL:\(user.profileUrl)")
            //print("description:\(user.tagline)")
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            print("error \(error.localizedDescription))")
            failure(error as NSError)
            
        })
    
    }
    
    func handleOpenUrl(url: NSURL){
        
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) ->Void in
            
            print(accessToken!)
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError!) in
                self.loginFailure?(error as! NSError)
            })
            
            
            
            
        }, failure: { (error : Error?) -> Void in
            print(error!.localizedDescription)
            self.loginFailure?(error as! NSError)
        })
    
    }
    
    
    
}
 
