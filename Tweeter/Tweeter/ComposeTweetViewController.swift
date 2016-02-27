//
//  ComposeTweetViewController.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/26/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var composeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.layer.borderWidth = 0.5
        composeTextView.layer.cornerRadius = 5
        composeTextView.text = "What's happening?"
        composeTextView.textColor = UIColor.lightGrayColor()
        composeTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(composeTextView: UITextView) {
        if composeTextView.textColor == UIColor.lightGrayColor() {
            composeTextView.text = nil
            composeTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(composeTextView: UITextView) {
        if composeTextView.text.isEmpty {
            composeTextView.text = "What's happening?"
            composeTextView.textColor = UIColor.lightGrayColor()
        }
    }
    
    @IBAction func sendTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.compose(composeTextView.text, params: nil) { (tweet, error) -> () in
            if (error == nil){
                tweetViewControllerReference?.tweets?.insert(tweet!, atIndex: 0)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
                self.presentViewController(vc, animated: true, completion: nil)
                // TweetsViewController
                //self.navigationController?.popViewControllerAnimated(true)
                
            }else{
                let alert = UIAlertController(title: nil, message: "Tweet Update Failed", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                self.presentViewController(alert,animated: true,completion: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
