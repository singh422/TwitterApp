//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by Avinash Singh on 03/03/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        
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
    @IBAction func onTapSend(_ sender: Any) {
        
        print("button pressed")
        
       
        TwitterClient.sharedInstance?.reply(id: "", text: self.tweetTextView.text!, success: { (response: Tweet) in
            print(self.tweetTextView.text!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            self.navigationController!.popViewController(animated: true)
            
        }, faliure: { (error: Error) in
            
            let errorAlertController = UIAlertController(title: "Error!", message: "Tweet too long", preferredStyle: .alert)
            let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                //dismiss
            }
            errorAlertController.addAction(errorAction)
            self.present(errorAlertController, animated: true)
            
        })
        
    }

}
