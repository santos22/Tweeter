//
//  User.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/18/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagLine: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    func logout() {
        // clear current user
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken() // remove permissions
        
        // NSNotifications to send out broadcasts
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object:  nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    } catch let parseError {
                        print(parseError)
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            // persist user
            if _currentUser != nil {
                do {
                    // try to store
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions())
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch let parseError {
                    print(parseError)
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
