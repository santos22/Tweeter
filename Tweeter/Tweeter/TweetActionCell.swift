//
//  TweetActionCell.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/28/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class TweetActionCell: UITableViewCell {
    
    var tweet: Tweet!

    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
