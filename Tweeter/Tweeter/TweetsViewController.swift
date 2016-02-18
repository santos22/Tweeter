//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/18/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?

    @IBOutlet weak var timelineTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineTableView.dataSource = self
        timelineTableView.delegate = self

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) ->() in
            self.tweets = tweets
            self.timelineTableView.reloadData()
            // tweet.favorite
        })
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        timelineTableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) ->() in
            self.tweets = tweets
            self.timelineTableView.reloadData()
            refreshControl.endRefreshing()
        })
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(timelineTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = timelineTableView.dequeueReusableCellWithIdentifier("timelineTweet", forIndexPath: indexPath) as! TweetCell
        let tweet = self.tweets![indexPath.row]
        let profileImageURL = NSURL(string: (tweet.user?.profileImageUrl)!)
        cell.profileImage.setImageWithURL(profileImageURL!)
        cell.name.text = tweet.user?.name
        cell.screenName.text = tweet.user?.screenName
        cell.timestamp.text = tweet.createdAtString
        cell.tweetText.text = tweet.text
        return cell
    }
    
    func tableView(timelineTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
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
