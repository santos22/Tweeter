//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/14/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

let twitterConsumerKey = "HrFzhSV4h2TzypbB3kA9E5aru"
let twitterConsumerSecret = "l0bwHOCjqDGH2mcUDKKMtg3DYUiQnQFf23nEO8PceRkBCYG56Q"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
