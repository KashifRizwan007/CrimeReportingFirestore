//
//  userInfo.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/19/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation

struct userInfo {
    var name:String
    var image:String
    var userType:String
    var email:String
    
    init(name:String,image:String,userType:String,email:String) {
        self.name = name
        self.image = image
        self.userType = userType
        self.email = email
    }
}
