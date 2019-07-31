//
//  ReportDetailsUserViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/27/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class ReportDetailsUserViewController: UIViewController {

    @IBOutlet weak var reportTitle: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var statusUpdate: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var contactNo: UITextField!
    @IBOutlet weak var imageViewProfile: UIImageViewRounded!
    
    var report:report!
    let gsdObj = gsdData()
    var boxView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillValues()
        self.contactNo.isEnabled = false
        
    }
    
    private func fillValues(){
        self.reportTitle.text = self.report.title
        self.descript.text = self.report.descript
        self.date.text = self.report.date
        self.statusUpdate.text = self.report.status
        self.city.text = self.report.city
        self.contactNo.text = self.report.contactNo
        if self.report.imgUrl != ""{
            URLSession.shared.dataTask( with: URL(string: self.report!.imgUrl)!, completionHandler: {
                (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if let data = data {
                        self.imageViewProfile.image = UIImage(data: data)
                    }
                }
            }).resume()
        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enableEdit(_ sender: Any) {
        self.contactNo.isEnabled = true
    }
    
    @IBAction func Update(_ sender: Any) {
        if let contact = self.contactNo.text{
            let alert = UIAlertController(title: "Alert", message: "Are you sure you want to update contact?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                self._loader()
                self.gsdObj.updateContact(contact: contact, id: self.report.reportId, completion: {(error) in
                    self.boxView.removeFromSuperview()
                    let alert = UIAlertController(title: "Done", message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(_) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            
        }
    }
    
    private func _loader() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 1.0
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.gray
        textLabel.text = "Updating..."
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }
    
}
