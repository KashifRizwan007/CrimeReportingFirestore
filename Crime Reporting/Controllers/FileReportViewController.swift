//
//  FileReportViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/20/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class FileReportViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    var currentTextField = UITextField()
    @IBOutlet weak var reportType: textFieldDesign!
    @IBOutlet weak var cityOut: textFieldDesign!
    @IBOutlet weak var contactNoOut: UITextField!
    @IBOutlet weak var descritpionOut: UITextField!
    @IBOutlet weak var titleOut: UITextField!
    @IBOutlet weak var submitOut: ButtonDesign!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var reportDate: textFieldDesign!
    
    var city = ["Karachi","Lahore","Islamabad","Rawalpindi"]
    var type = ["Missing Person","Crime","Complaint"]
    var pickerView = UIPickerView()
    var submitObj:submitReport!
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        loader.isHidden = true
        loader.hidesWhenStopped = true
        showDatePicker()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func submit(_ sender: Any) {
        self.loader.startAnimating()
        self.submitOut.isEnabled = false
        if let type = self.reportType.text, let city = self.cityOut.text, let contactNo = self.contactNoOut.text, let title = self.titleOut.text, let descript = self.descritpionOut.text, let date = self.reportDate.text{
            self.submitObj = submitReport(type: type, city: city, contactNo: contactNo, title: title, descript: descript, date:date)
            self.submitObj.submitReportData( completion: {(error) in
                self.loader.stopAnimating()
                self.submitOut.isEnabled = true
                if error != nil{
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Success", message: "Report submitted successfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }    }
    
}

extension FileReportViewController{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == cityOut{
            return self.city.count
        }else if currentTextField == reportType{
            return self.type.count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == cityOut{
            return self.city[row]
        }else if currentTextField == reportType{
            return self.type[row]
        }else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == cityOut{
            self.currentTextField.text = self.city[row]
        }else if currentTextField == reportType{
            self.currentTextField.text = self.type[row]
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
        
        self.currentTextField = textField
        
        self.pickerView.reloadAllComponents()
        
        self.currentTextField.inputView = pickerView
    }
    
    private func showDatePicker(){
        //Formate Date
        self.datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        reportDate.inputAccessoryView = toolbar
        reportDate.inputView = datePicker
        
    }
    
    @objc private func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        reportDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func cancelPicker(){
        self.view.endEditing(true)
    }
}
