//
//  ReportDetailsAdminViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/27/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

protocol loadChange{
    func loadAllData()
}

class ReportDetailsAdminViewController: UIViewController {
    
    @IBOutlet weak var reportTitle: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var statusUpdate: UIButton!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var contactNo: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageViewRounded!
    
    var report:report!
    let gsdObj = gsdData()
    var boxView = UIView()
    
    var delegate:loadChange?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillValues()
        // Do any additional setup after loading the view.
    }
    
    private func fillValues(){
        self.reportTitle.text = self.report.title
        self.descript.text = self.report.descript
        self.date.text = self.report.date
        
        self.statusUpdate.setTitle(self.report.status, for: .normal)
        self.renderStatusBtn()
        
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
    
    private func renderStatusBtn(){
        switch self.statusUpdate.titleLabel?.text{
        case "Pending":
            self.statusUpdate.backgroundColor = .yellow
        case "Inprogress":
            self.statusUpdate.backgroundColor = .blue
        case "Completed":
            self.statusUpdate.backgroundColor = .green
        default:
            self.statusUpdate.backgroundColor = .red
        }
    }
    
    @IBAction func statusChange(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Report Status", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Pending", style: .default, handler: {(_) in
            self.statusUpdate.setTitle("Pending", for: .normal)
            self.statusUpdate.backgroundColor = .yellow
        }))
        actionSheet.addAction(UIAlertAction(title: "Inprogress", style: .default, handler: {(_) in
            self.statusUpdate.setTitle("Inprogress", for: .normal)
            self.statusUpdate.backgroundColor = .blue
        }))
        actionSheet.addAction(UIAlertAction(title: "Completed", style: .default, handler: {(_) in
            self.statusUpdate.setTitle("Completed", for: .normal)
            self.statusUpdate.backgroundColor = .green
        }))
        actionSheet.addAction(UIAlertAction(title: "Rejected", style: .default, handler: {(_) in
            self.statusUpdate.setTitle("Rejected", for: .normal)
            self.statusUpdate.backgroundColor = .red
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func Update(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to update status?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            self._loader()
            self.gsdObj.updateStatus(status: self.statusUpdate.titleLabel!.text!, id: self.report.reportId, completion: {(error) in
                self.boxView.removeFromSuperview()
                let alert = UIAlertController(title: "Done", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {(_) in
                    if self.delegate != nil{
                        self.delegate?.loadAllData()
                        self.navigationController?.popViewController(animated: true)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
