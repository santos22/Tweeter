//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/26/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user:User?
    var tweets:[Tweet]?
    var tweet: Tweet!
    
    @IBOutlet weak var profilePageView: ProfilePageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePageView.user = user
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 160
        
        if let user = self.user{
            print(user.userID)
            TwitterClient.sharedInstance.userTimelineWithParams(user.userID!, params: nil) { (tweets, error) -> () in
                self.tweets = tweets
                //print(tweets)
                self.tableView.reloadData()
            }
            
            //self.navigationItem.title = user.screenName!
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
//    func tableView(timelineTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let tweets = tweets {
//            return tweets.count
//        } else {
//            return 0
//        }
//    }
//    
//    func tableView(timelineTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = timelineTableView.dequeueReusableCellWithIdentifier("profileTweet", forIndexPath: indexPath) as! ProfileCell
//        let tweet = self.tweets![indexPath.row]
//        cell.tweet = tweet
//        let profileImageURL = NSURL(string: (tweet.user?.profileImageUrl)!)
//        cell.profileImage.setImageWithURL(profileImageURL!)
//        cell.name.text = tweet.user?.name
//        cell.screenName.text = tweet.user?.screenName
//        //cell.timestamp.text = tweet.createdAtString
//        //cell.tweetText.text = tweet.text
//        //cell.retweetLabel.text = String(tweet.retweetCount!)
//        //cell.likeLabel.text = String(tweet.likeCount!)
//        
//        return cell
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
