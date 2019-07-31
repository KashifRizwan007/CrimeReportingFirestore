//
//  report.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/24/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation

struct report {
    var city : String
    var contactNo : String
    var descript : String
    var id : String
    var status : String
    var title : String
    var type : String
    var reportId : String
    var imgUrl:String
    var date:String
    
    init(city : String, contactNo : String, descript : String, id : String, status : String, title : String, type : String, reportId : String, imgUrl:String, date:String){
        self.city = city
        self.contactNo = contactNo
        self.descript = descript
        self.id = id
        self.status = status
        self.title = title
        self.type = type
        self.reportId = reportId
        self.imgUrl = imgUrl
        self.date = date
    }
}
