//
//  loginRequest.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct loginRequest {
    private var email:String
    private var password:String
    private let db = Firestore.firestore()
    
    init(email:String, password:String) {
        self.email = email
        self.password = password
    }
    
    func loginRequest( completion: @escaping (_ error: String? , _ isLogin: Bool?) -> ()){
        Auth.auth().signIn(withEmail: self.email, password: self.password, completion: {(user,error) in
            if let err = error{
                print(err.localizedDescription)
                completion(err.localizedDescription,false)
            }else{
                self.getData(completion: {(error,userData) in
                    if let err = error{
                        completion(err,false)
                    }else{
                        staticLinker.userInformation = userData
                        completion(nil,true)
                    }
                })
            }
        })
    }
    
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
