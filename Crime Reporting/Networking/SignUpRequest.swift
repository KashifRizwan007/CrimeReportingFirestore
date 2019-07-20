//
//  File.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class SignUpRequest{
    
    let db = Firestore.firestore()
    
    private var name:String
    private var email:String
    private var password:String
    
    init(name:String, email:String, password:String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func signUpRequest(image:UIImage?, completion: @escaping (_ error: String? , _ isLogin: Bool?) -> ()){
        Auth.auth().createUser(withEmail: self.email, password: self.password, completion: {(user, error) in
            if let err = error{
                completion(err.localizedDescription,false)
            }else{
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.name
                changeRequest?.commitChanges(completion: {(error) in
                    if let err = error{
                        print(err.localizedDescription)
                        completion(nil,false)
                    }else{
                        self.createUser(image: image, completion: {(error) in
                            if let err = error{
                                completion(err,false)
                            }else{
                                completion(nil,true)
                            }
                        })
                    }
                })
            }
        })
    }
    private func createUser(image:UIImage?, completion: @escaping (_ error: String?) -> ()){
        if let img = image{
            self.uploadProfileImage(image:img, completion: {(error,url) in
                if let err = error{
                    completion(err)
                }else if let Url = url{
                    self.db.collection("users").document(Auth.auth().currentUser!.uid).setData(["email":self.email,"name":self.name,"userType":"user","image": Url.absoluteString], completion: {(error) in
                        if let err = error{
                            completion(err.localizedDescription)
                        }else{
                            completion(nil)
                        }
                    })
                }
            })
        }else{
            self.db.collection("users").document(Auth.auth().currentUser!.uid).collection("userInfo").addDocument(data: ["email":self.email,"name":self.name,"image":""], completion: {(error) in
                if let err = error{
                    completion(err.localizedDescription)
                }else{
                    completion(nil)
                }
            })
        }
    }
    
    private func uploadProfileImage(image:UIImage?, completion: @escaping (_ error: String?,_ url:URL?) -> ()){
        let data = image!.jpegData(compressionQuality: 1.0)
        let imageUpload = Storage.storage().reference().child("Images/\(String(describing: Auth.auth().currentUser?.uid))/profilePic.jpg")
        _ = imageUpload.putData(data!, metadata: nil) { (metadata, error) in
            if let err = error {
                completion(err.localizedDescription,nil)
            }else{
                imageUpload.downloadURL(completion: { (url, error) in
                    if let err = error {
                        completion(err.localizedDescription,nil)
                    }else{
                        completion(nil,url)
                    }
                })
            }
        }
    }
}
