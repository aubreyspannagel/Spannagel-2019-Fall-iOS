//
//  Chat.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/15/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit

class Chat: NSObject {
    var users: [String]?
    var dictionary: [String: Any]{
        return["users": users!]
    }
}

