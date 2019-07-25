//
//  submitReport.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/20/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct submitReport {
    let db = Firestore.firestore()
    
    var type:String
    var city:String
    var contactNo:String
    var title:String
    var descript:String
    
    init(type:String, city:String, contactNo:String, title:String, descript:String) {
        self.type = type
        self.city = city
        self.contactNo = contactNo
        self.title = title
        self.descript = descript
    }
    
    func submitReportData( completion: @escaping (_ error: String?) -> ()){
        self.db.collection("reports").document().setData( ["id":Auth.auth().currentUser!.uid,"type":self.type,"city":self.city,"contactNo":self.contactNo,"title":self.title,"descript":self.descript,"status":"Pending","imgUrl":staticLinker.userInformation.image], completion: {(error) in
            if let err = error{
                completion(err.localizedDescription)
            }else{
                completion(nil)
            }
        })
    }
}
