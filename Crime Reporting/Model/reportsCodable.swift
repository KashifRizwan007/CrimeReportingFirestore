//
//  reports.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/24/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation

struct reportCodable: Codable {
    
    let city : String?
    let contactNo : String?
    let descript : String?
    let id : String?
    let status : String?
    let title : String?
    let type : String?
    let imageUrl : String?
    let date : String?
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case contactNo = "contactNo"
        case descript = "descript"
        case id = "id"
        case status = "status"
        case title = "title"
        case type = "type"
        case imageUrl = "imgUrl"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        contactNo = try values.decodeIfPresent(String.self, forKey: .contactNo)
        descript = try values.decodeIfPresent(String.self, forKey: .descript)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }
    
}
