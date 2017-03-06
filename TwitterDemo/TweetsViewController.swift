//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 27/02/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//




import UIKit


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {

    
    
    var tweets12: [Tweet]!
    var num = 0
    
        @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets12 = tweets
            self.tableView.reloadData()
            
            
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
        
        
        
        
        //tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func loadList(notification: NSNotification){
        //load data here
        
        print("it's coming here")
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets12 = tweets
            self.tableView.reloadData()
            
            
        }, failure: { (error: NSError) in
            print(error.localizedDescription)
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
      TwitterClient.sharedInstance?.logout()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets12 != nil{
            
            
        return tweets12!.count
            
        }
        else {
            //print("i came here ***********************232123")
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =   tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.layer.borderWidth = 0.25
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.selectionStyle = .none
        
        cell.tweet = tweets12[indexPath.row]
        cell.delegate = self
        
        //let tweet = tweets12[indexPath.row]
        
        //cell.tweetLabel.text = tweet.text as String!
        return cell
    
    }
    
    
    
    func showUserProfile(cell: TweetCell, user: User)
   {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let profileVC = storyboard.instantiateViewController(withIdentifier: "UsersProfileViewController") as? UsersProfileViewController {
        profileVC.user = user
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    }
    

    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if  let cell = sender as? UITableViewCell{
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets12![indexPath!.row]
        let tweetViewController = segue.destination as! TweetViewController
        tweetViewController.tweet = tweet
        }
        
        else{
        
        }
      
        
        
    }
   
    

}
