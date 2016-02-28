//
//  TweetStatsCell.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/28/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class TweetStatsCell: UITableViewCell {
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var llikeLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            retweetCount.text = String(tweet!.retweetCount!)
            likeCount.text = String(tweet!.likeCount!)
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
