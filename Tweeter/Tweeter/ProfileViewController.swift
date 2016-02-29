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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePageView.user = user
        
        if let user = self.user{
            print(user.userID)
            TwitterClient.sharedInstance.userTimelineWithParams(user.userID!, params: nil) { (tweets, error) -> () in
                self.tweets = tweets
                //print(tweets)
                //self.tableView.reloadData()
            }
            
            //self.navigationItem.title = user.screenName!
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
