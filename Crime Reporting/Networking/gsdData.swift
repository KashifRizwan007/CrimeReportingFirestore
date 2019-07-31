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
    private let type1 = "city"
    private let type2 = "status"
    
    func getCrimesReports (filter1:String?, filter2:String?, completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        
        if staticLinker.userInformation.userType == "user"{
            if let fltr1 = filter1{
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").whereField("id", isEqualTo: self.uid).whereField("city", isEqualTo: fltr1).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else {
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            if let fltr1 = filter1, let fltr2 = filter2{
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").whereField(type1, isEqualTo: fltr1).whereField(self.type2, isEqualTo: fltr2).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else if let fltr1 = filter1{
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").whereField(type1, isEqualTo: fltr1).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else if let fltr2 = filter2 {
                self.db.collection("reports").whereField("type", isEqualTo: "Crime").whereField(self.type2, isEqualTo: fltr2).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func getMissingReports (filter1:String?, filter2:String?, completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        
        if staticLinker.userInformation.userType == "user"{
            if let fltr1 = filter1{
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").whereField("id", isEqualTo: self.uid).whereField("city", isEqualTo: fltr1).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else {
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            if let fltr1 = filter1, let fltr2 = filter2{
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").whereField(type1, isEqualTo: fltr1).whereField(self.type2, isEqualTo: fltr2).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else if let fltr1 = filter1{
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").whereField(type1, isEqualTo: fltr1).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else if let fltr2 = filter2 {
                self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").whereField(self.type2, isEqualTo: fltr2).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
    
    func getComplaintsReports (filter1:String?, filter2:String?, completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        
        if staticLinker.userInformation.userType == "user"{
            if let fltr1 = filter1{
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").whereField("id", isEqualTo: self.uid).whereField("city", isEqualTo: fltr1).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else {
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            if let fltr1 = filter1, let fltr2 = filter2{
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").whereField(type1, isEqualTo: fltr1).whereField(self.type2, isEqualTo: fltr2).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else if let fltr1 = filter1{
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").whereField(type1, isEqualTo: fltr1).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
            }else if let fltr2 = filter2 {
                self.db.collection("reports").whereField("type", isEqualTo: "Complaint").whereField(self.type2, isEqualTo: fltr2).getDocuments(completion: {(snapshot,error) in
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
                                DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
    
    func updateContact(contact: String, id:String, completion: @escaping (_ error: String?) -> ()){
        self.db.collection("reports").document(id).updateData(["contactNo":contact]){(error) in
            if let err = error{
                completion(err.localizedDescription)
            }else{
                completion(nil)
            }
        }
    }
    
    func updateStatus(status: String, id:String, completion: @escaping (_ error: String?) -> ()){
        self.db.collection("reports").document(id).updateData(["status":status]){(error) in
            if let err = error{
                completion(err.localizedDescription)
            }else{
                completion(nil)
            }
        }
    }
    
    func crimeListner( completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        self.db.collection("reports").whereField("type", isEqualTo: "Crime").addSnapshotListener( {(snapshot,error) in
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
                        DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
    
    func missingPersonListner( completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        self.db.collection("reports").whereField("type", isEqualTo: "Missing Person").addSnapshotListener( {(snapshot,error) in
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
                        DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
    
    func complaintsListner( completion:  @escaping ( _ error: String? , _ toDoData:[report]?) -> ()){
        self.db.collection("reports").whereField("type", isEqualTo: "Complaint").addSnapshotListener( {(snapshot,error) in
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
                        DataArray.append(report(city: temp.city!, contactNo: temp.contactNo!, descript: temp.descript!, id: temp.id!, status: temp.status!, title: temp.title!, type: temp.type!, reportId: documents.documentID, imgUrl: temp.imageUrl!, date: temp.date!))
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
