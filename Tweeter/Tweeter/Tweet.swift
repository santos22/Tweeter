//
//  Tweet.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/18/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User? // author
    var text: String?
    var retweetCount: Int?
    var likeCount: Int?
    var createdAtString: String?
    var createdAt: NSDate?
    var tweetID: String?
    var hasRetweeted = false
    var hasLiked = false
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        likeCount = dictionary["favorite_count"] as? Int
        createdAtString = dictionary["created_at"] as? String // need to format date
        tweetID = dictionary["id_str"] as? String
        hasRetweeted = dictionary["retweeted"] as! Bool
        hasLiked = dictionary["favorited"] as! Bool
        
        let formatter = NSDateFormatter() // really expensive
        //formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let test = NSDateFormatter()
        test.dateFormat = "h:mm a"
        //test.dateFormat = "M/d/yy - h:mm a"
        
        createdAtString = test.stringFromDate(createdAt!)
        //print(dateString)
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) ->[Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
