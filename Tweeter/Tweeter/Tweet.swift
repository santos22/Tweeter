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
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String // need to format date
        
        let formatter = NSDateFormatter() // really expensive
        //formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let test = NSDateFormatter()
        test.dateFormat = "M/d/yy - h:mm a"
        
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
