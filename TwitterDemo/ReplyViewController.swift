//
//  ReplyViewController.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 02/03/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    @IBOutlet weak var replyTextView: UITextView!
    var tweet : Tweet?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tweet != nil {
        replyTextView.text = "@\(tweet!.screenName!)"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func sendButton(_ sender: Any) {
        
        
        print("button was clicked")
        TwitterClient.sharedInstance?.reply(id: (tweet?.id_str)!, text: replyTextView.text!, success: { (response: Tweet) in
            
            print(self.replyTextView.text!)
            self.navigationController!.popViewController(animated: true)

        }, faliure: { (error: Error) in
            
            let errorAlertController = UIAlertController(title: "Error!", message: "Already replied to this Tweet", preferredStyle: .alert)
            let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                //dismiss
            }
            errorAlertController.addAction(errorAction)
            self.present(errorAlertController, animated: true)
            
        })
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
