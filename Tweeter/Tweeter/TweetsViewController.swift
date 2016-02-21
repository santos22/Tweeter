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
        timelineTableView.rowHeight = UITableViewAutomaticDimension
        timelineTableView.estimatedRowHeight = 120

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
        cell.tweet = tweet
        let profileImageURL = NSURL(string: (tweet.user?.profileImageUrl)!)
        cell.profileImage.setImageWithURL(profileImageURL!)
        cell.name.text = tweet.user?.name
        cell.screenName.text = tweet.user?.screenName
        cell.timestamp.text = tweet.createdAtString
        cell.tweetText.text = tweet.text
        cell.retweetLabel.text = String(tweet.retweetCount!)
        cell.likeLabel.text = String(tweet.likeCount!)
        
        let retweetTapAction = UITapGestureRecognizer(target: self, action: "retweet:")
        cell.retweetImageView.tag = indexPath.row
        cell.retweetImageView.userInteractionEnabled = true
        cell.retweetImageView.addGestureRecognizer(retweetTapAction)
        if tweet.hasRetweeted{
            cell.retweetImageView.highlighted = true
        }
        
        let likeTapAction = UITapGestureRecognizer(target: self, action: "like:")
        cell.likeImageView.tag = indexPath.row
        cell.likeImageView.userInteractionEnabled = true
        cell.likeImageView.addGestureRecognizer(likeTapAction)
        if tweet.hasLiked{
            cell.retweetImageView.highlighted = true
        }
        
        //cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(timelineTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func retweet(sender: UITapGestureRecognizer){
        if sender.state != .Ended{
            return
        }
        
        let index = sender.view?.tag
        if let index = index{
            let cell = timelineTableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! TweetCell
            if (!cell.tweet!.hasRetweeted){
                TwitterClient.sharedInstance.retweet(tweets![index].tweetID!, params: nil, completion: { (response, error) -> () in
                    if (error == nil){
                        self.tweets![index].retweetCount! += 1
                        self.tweets![index].hasRetweeted = true
                        cell.retweetLabel!.text = String(Int(cell.retweetLabel.text!)! + 1)
                        cell.tweet!.hasRetweeted = true
                        cell.retweetImageView.highlighted = true
                    }else{
                        print("Retweet failed: \(error!.description)")
                    }
                })
            }
        }
    }
    
    func like(sender: UITapGestureRecognizer){
        if sender.state != .Ended{
            return
        }
        
        let index = sender.view?.tag
        if let index = index{
            let cell = timelineTableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! TweetCell
            if (!cell.tweet!.hasRetweeted){
                TwitterClient.sharedInstance.like(tweets![index].tweetID!, params: nil, completion: { (response, error) -> () in
                    if (error == nil){
                        self.tweets![index].likeCount! += 1
                        self.tweets![index].hasLiked = true
                        cell.likeLabel!.text = String(Int(cell.likeLabel.text!)! + 1)
                        cell.tweet!.hasLiked = true
                        cell.likeImageView.highlighted = true
                    }else{
                        print("Like failed: \(error!.description)")
                    }
                })
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
