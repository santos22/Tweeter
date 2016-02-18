//
//  User.swift
//  Tweeter
//
//  Created by Santos Solorzano on 2/18/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

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
}
