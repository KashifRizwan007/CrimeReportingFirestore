//
//  getUserData.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 8/2/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct getUserData {
    
    let db = Firestore.firestore()
    
    func getData (completion:  @escaping (_ error:String?, _ userInformation:userInfo?) -> ()){
        self.db.collection("users").document(Auth.auth().currentUser!.uid).addSnapshotListener({(snapshot,error) in
            if let err = error{
                completion(err.localizedDescription,nil)
            }else{
                let data = self.db.collection("users").document(Auth.auth().currentUser!.uid)
                data.getDocument(completion: {(document,error) in
                    if let _name = document?.data()!["name"] as? String, let _image = document?.data()!["image"] as? String, let userType = document?.data()!["userType"] as? String, let email = document?.data()!["email"] as? String{
                        let userInformation = userInfo(name: _name, image: _image, userType: userType, email: email)
                        completion(nil,userInformation)
                    }else{
                        completion("Network Error",nil)
                    }
                })
            }
        })
    }
}
