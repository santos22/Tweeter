//
//  TweetDetailCell.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/28/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class TweetDetailCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var tweetTimestamp: UILabel!
    
    var tweet: Tweet? {
        didSet {
            let imagePath = NSURL(string: (tweet?.user?.profileImageUrl)!)
            profileImageView.setImageWithURL(imagePath!)
            nameLabel.text = tweet?.user?.name
            screennameLabel.text = tweet?.user?.screenName
            tweetContent.text = tweet?.text
            tweetTimestamp.text = tweet?.createdAtString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
