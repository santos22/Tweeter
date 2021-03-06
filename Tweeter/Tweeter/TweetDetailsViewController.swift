//
//  TweetDetailsViewController.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/26/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweet: Tweet!
    @IBOutlet weak var tableView: UITableView!
    var tweetDetails: TweetDetailCell!
    var tweetStats: TweetStatsCell!
    var tweetActions: TweetActionCell!
    var replyToUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }

    @IBAction func goBack(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0: //Tweet content cell
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailsCell") as! TweetDetailCell
            cell.tweet = tweet
            tweetDetails = cell
            return cell
        case 1: // Tweet stat cell
            let cell = tableView.dequeueReusableCellWithIdentifier("StatCell") as! TweetStatsCell
            cell.tweet = tweet
            tweetStats = cell
            return cell
        case 2: // Tweet action cell
            let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell") as! TweetActionCell

            cell.tweet = tweet
            
            let replyTapAction = UITapGestureRecognizer(target: self, action: "reply:")
            cell.replyImage.tag = indexPath.row
            cell.replyImage.userInteractionEnabled = true
            replyToUser = (cell.tweet.user?.screenName)!
            cell.replyImage.addGestureRecognizer(replyTapAction)
            
            let retweetTapAction = UITapGestureRecognizer(target: self, action: "retweet:")
            cell.retweetImage.tag = indexPath.row
            cell.retweetImage.userInteractionEnabled = true
            cell.retweetImage.addGestureRecognizer(retweetTapAction)
            if tweet.hasRetweeted{
                cell.retweetImage.highlighted = true
            }
            
            let likeTapAction = UITapGestureRecognizer(target: self, action: "like:")
            cell.likeImage.tag = indexPath.row
            cell.likeImage.userInteractionEnabled = true
            cell.likeImage.addGestureRecognizer(likeTapAction)
            if tweet.hasLiked{
                cell.likeImage.highlighted = true
            }
            
            tweetActions = cell
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    func retweet(sender: UITapGestureRecognizer){
        if sender.state != .Began {
            TwitterClient.sharedInstance.retweet(tweet.tweetID!, params: nil, completion: { (retweetCount) -> () in
                //self.tweet.retweetCount! += 1
                self.tweet.hasRetweeted = true
                self.tweetStats.retweetCount.text = String(self.tweet.retweetCount! + 1)
            })
        }
    }
    
    func like(sender: UITapGestureRecognizer){
        if sender.state != .Began {
            TwitterClient.sharedInstance.like(tweet.tweetID!, params: nil, completion: { (retweetCount) -> () in
                //self.tweet.likeCount! += 1
                self.tweet.hasLiked = true
                self.tweetStats.likeCount.text = String(self.tweet.likeCount! + 1)
            })
        }
    }
    
    func reply(sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ComposeTweetViewController") as! ComposeTweetViewController
        //vc.composeTextView.text = "@hey"

        print("User is: \(replyToUser)")
        self.presentViewController(vc, animated: true, completion: nil)
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
