//
//  getData.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/24/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct gsdData{
    
    let db = Firestore.firestore()
    private let uid = String(Auth.auth().currentUser!.uid)
    
    func getCrimesReports (filter:String?, completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        
        if staticLinker.userInformation.userType == "user"{
            if let fltr = filter{
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").whereField("id", isEqualTo: self.uid).whereField("city", isEqualTo: fltr).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }else{
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").whereField("id", isEqualTo: self.uid).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }
        }else{
            if let fltr = filter{
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").whereField("city", isEqualTo: fltr).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }else{
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }
        }
        
        
    }
    
    func getMissingReports (filter:String?, completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        
        if staticLinker.userInformation.userType == "user"{
            if let fltr = filter{
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").whereField("id", isEqualTo: self.uid).whereField("city", isEqualTo: fltr).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }else{
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").whereField("id", isEqualTo: self.uid).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }
        }else{
            if let fltr = filter{
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").whereField("city", isEqualTo: fltr).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }else{
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }
        }
        
    }
    
    func getComplaintsReports (filter:String?, completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        
        if staticLinker.userInformation.userType == "user"{
            if let fltr = filter{
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").whereField("id", isEqualTo: self.uid).whereField("city", isEqualTo: fltr).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }else{
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").whereField("id", isEqualTo: self.uid).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }
        }else{
            if let fltr = filter{
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").whereField("city", isEqualTo: fltr).getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }else{
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").getDocuments(completion: {(snapshot,error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        var temp:reportCodable
                        var DataArray = [report]()
                        for documents in snapshot!.documents{
                            let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                            let decoder = JSONDecoder()
                            do
                            {
                                temp = try decoder.decode(reportCodable.self, from: jsonData)
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!))
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                        if DataArray.count == 0{
                            completion(nil,nil)
                        }else{
                            completion(nil,DataArray)
                        }
                    }
                })
            }
        }
    }
    
    func deleteReport(id:String, completion: @escaping (_ error: String?) -> ()){
        self.db.collection("reports").document(id).delete(){(error) in
            if let err = error{
                completion(err.localizedDescription)
            }else{
                completion(nil)
            }
        }
    }

}
