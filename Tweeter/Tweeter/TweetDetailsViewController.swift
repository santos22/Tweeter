//
//  TweetDetailsViewController.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/26/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            print(tweet.user!.profileImageUrl)
            print(tweet.user?.name)
            print(tweet.user?.screenName)
            print(tweet.text)
            print(tweet.createdAtString)
            print(tweet.likeCount)
            print(tweet.retweetCount)
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
