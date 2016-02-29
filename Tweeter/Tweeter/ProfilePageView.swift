//
//  ProfilePageView.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/28/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class ProfilePageView: UIView {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var user: User? {
        didSet{
            let bannerPath = NSURL(string: (user?.profileBannerUrl)!)
            bannerImageView.setImageWithURL(bannerPath!)
            let profilePath = NSURL(string: (user?.profileImageUrl)!)
            profileImageView.setImageWithURL(profilePath!)
            name.text = user?.name
            username.text = user?.screenName
            followingCount.text = user!.followingCountString
            followersCount.text = user!.followerCountString
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
