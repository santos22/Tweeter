//
//  TweetCell.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/18/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    var tweets: [Tweet]?
    var tweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("retweetTapped:"))
//        retweetImageView.userInteractionEnabled = true
//        retweetImageView.addGestureRecognizer(tapGestureRecognizer)
        // Initialization code
        tweetText.preferredMaxLayoutWidth = tweetText.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetText.preferredMaxLayoutWidth = tweetText.frame.size.width
    }
    
//    func retweetTapped(img: AnyObject) {
//        TwitterClient.sharedInstance.retweet(nil, completion: { (tweets, error) ->() in
//            self.tweets = tweets
//            
//            for tweet in tweets! {
//                print(tweet.text)
//            }
//        })
//        print("Tapped")
//    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
