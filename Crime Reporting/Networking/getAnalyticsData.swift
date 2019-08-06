//
//  getAnalyticsData.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 8/5/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct getAnalyticsData {
    
    let db = Firestore.firestore()
    
    func getCrimeCounts(completion:  @escaping (_ error:String?, _ crimeRecord:[String:Any]?) -> ()){
        var karachiData = 0.0
        var lahoreData = 0.0
        var islamabadData = 0.0
        var rawalpindiData = 0.0
        
        var karachiCrime = 0.0
        var lahoreCrime = 0.0
        var islamabadCrime = 0.0
        var rawalpindiCrime = 0.0
        
        var karachiComplaints = 0.0
        var lahoreComplaints = 0.0
        var islamabadComplaints = 0.0
        var rawalpindiComplaints = 0.0
        
        var karachiMissing = 0.0
        var lahoreMissing = 0.0
        var islamabadMissing = 0.0
        var rawalpindiMissing = 0.0
        
         self.db.collection("reports").getDocuments(completion: {(snapshot,error) in
            if let err = error{
                completion(err.localizedDescription,nil)
            }else{
                for i in snapshot!.documents{
                    if i["city"] as! String == "Karachi"{
                        karachiData += 1.0
                    }else if i["city"] as! String == "Lahore"{
                        lahoreData += 1.0
                    }else if i["city"] as! String == "Islamabad"{
                        islamabadData += 1.0
                    }else if i["city"] as! String == "Rawalpindi"{
                        rawalpindiData += 1.0
                    }
                    
                    if i["city"] as! String == "Karachi" && i["type"] as! String == "Crime"{
                        karachiCrime += 1.0
                    }else if i["city"] as! String == "Lahore" && i["type"] as! String == "Crime"{
                        lahoreCrime += 1.0
                    }else if i["city"] as! String == "Islamabad" && i["type"] as! String == "Crime"{
                        islamabadCrime += 1.0
                    }else if i["city"] as! String == "Rawalpindi" && i["type"] as! String == "Crime"{
                        rawalpindiCrime += 1.0
                    }
                    
                    if i["city"] as! String == "Karachi" && i["type"] as! String == "Complaint"{
                        karachiComplaints += 1.0
                    }else if i["city"] as! String == "Lahore" && i["type"] as! String == "Complaint"{
                        lahoreComplaints += 1.0
                    }else if i["city"] as! String == "Islamabad" && i["type"] as! String == "Complaint"{
                        islamabadComplaints += 1.0
                    }else if i["city"] as! String == "Rawalpindi" && i["type"] as! String == "Complaint"{
                        rawalpindiComplaints += 1.0
                    }
                    
                    if i["city"] as! String == "Karachi" && i["type"] as! String == "Missing Person"{
                        karachiMissing += 1.0
                    }else if i["city"] as! String == "Lahore" && i["type"] as! String == "Missing Person"{
                        lahoreMissing += 1.0
                    }else if i["city"] as! String == "Islamabad" && i["type"] as! String == "Missing Person"{
                        islamabadMissing += 1.0
                    }else if i["city"] as! String == "Rawalpindi" && i["type"] as! String == "Missing Person"{
                        rawalpindiMissing += 1.0
                    }
                }
                completion(nil,["data1":[karachiData,lahoreData,islamabadData,rawalpindiData],"data2":["crime":[karachiCrime,lahoreCrime,islamabadCrime,rawalpindiCrime],"complaints":[karachiComplaints,lahoreComplaints,islamabadComplaints,rawalpindiComplaints],"missing":[karachiMissing,lahoreMissing,islamabadMissing,rawalpindiMissing]]])
                
            }
         })
    }
}
