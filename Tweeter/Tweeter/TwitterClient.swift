//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/14/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "HrFzhSV4h2TzypbB3kA9E5aru"
let twitterConsumerSecret = "l0bwHOCjqDGH2mcUDKKMtg3DYUiQnQFf23nEO8PceRkBCYG56Q"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError) -> ()) {
        loginCompletion = completion
        
        // fetch request token & redirect back authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken:
                BDBOAuth1Credential!) -> Void in
                print("Got the request token")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath(
            "oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: { (accessToken:
                BDBOAuth1Credential!) -> Void in
                print("Got the access token!")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                // get current user
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                    //print("user: \(response)")
                    let user = User(dictionary: response as! NSDictionary)
                    print("user: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
                    
                    }, failure: { (operation: NSURLSessionDataTask?, error:NSError) -> Void in
                        print("Error getting user")
                        self.loginCompletion?(user: nil, error: error)
                })
                
                // get timeline of tweets
                TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                    //print("home: \(response)")
                    var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                    
                    for tweet in tweets {
                        print("text: \(tweet.text), created: \(tweet.createdAt)")
                    }
                    }, failure: { (operation: NSURLSessionDataTask?, error:NSError) -> Void in
                        print("Error getting home time line")
                })
                
            }) { (error: NSError!) -> Void in
                print("Error getting access token")
                self.loginCompletion?(user: nil, error: error)
            }
    }
}
