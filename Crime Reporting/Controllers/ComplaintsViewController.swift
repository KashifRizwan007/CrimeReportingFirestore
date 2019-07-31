//
//  ComplaintsViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/25/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class ComplaintsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,loadChange{
    
    func loadAllData() {
        self.loadAllData()
    }
    
    @IBOutlet weak var complaintsTableView: UITableView!
    @IBOutlet weak var tabBarBadge: UITabBarItem!
    private var complaintsDataList:[report]!
    private var complaintsDataListListner:[report]!
    private var msg = "Loading..."
    var refreshControl = UIRefreshControl()
    var boxView = UIView()
    var data:report!
    var gsdDataObj = gsdData()
    let EmptyView = UIView()
    var filterChoiceCity:String? = "All"
    var filterChoiceReportStatus:String? = "All"
    let pickerViewCityGroups = ["All","Karachi","Lahore","Islamabad","Rawalpindi"]
    let pickerViewReportStatusGroups = ["All","Pending","Inprogress","Completed","Rejected"]
    var pickerChoice:[String]!
    private var status = false
    private var filterStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataListner()
        self.complaintsTableView.delegate = self
        self.complaintsTableView.dataSource = self
        self.loadData()
        complaintsTableView.rowHeight = UITableView.automaticDimension
        complaintsTableView.estimatedRowHeight = 108
        complaintsTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    func dataListner(){
        gsdDataObj.complaintsListner(completion: {(error, crimeData) in
            DispatchQueue.main.async {
                self.refreshControl.beginRefreshing()
                if let err = error{
                    self.msg = err
                    self.complaintsDataListListner = nil
                    self.complaintsTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }else{
                    self.refreshControl.endRefreshing()
                    if crimeData != nil{
                        self.complaintsDataListListner = crimeData
                        self.complaintsTableView.reloadData()
                    }else{
                        self.msg = "No Crime Reports"
                        self.complaintsDataListListner = nil
                        self.complaintsTableView.reloadData()
                    }
                }
                if self.complaintsDataListListner != nil{
                    self.tabBarBadge.badgeValue = String(self.complaintsDataListListner.count)
                    self.tabBarBadge.badgeColor = .black
                }else{
                    self.tabBarBadge.badgeValue = "0"
                    self.tabBarBadge.badgeColor = .red
                }
            }
        })
    }
    
    func filter() {
        if staticLinker.userInformation.userType == "user"{
            self.pickerChoice = pickerViewCityGroups
            self.pickerVIewGenerator(label: "city")
        }else{
            let actionSheet = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Show All", style: .default, handler: {(_) in
                self.filterChoiceCity = "All"
                self.filterChoiceReportStatus = "All"
                self.loadData()
            }))
            actionSheet.addAction(UIAlertAction(title: "City", style: .default, handler: {(_) in
                self.pickerChoice = self.pickerViewCityGroups
                self.pickerVIewGenerator(label: "city")
            }))
            actionSheet.addAction(UIAlertAction(title: "Report Type", style: .default, handler: {(_) in
                self.pickerChoice = self.pickerViewReportStatusGroups
                self.pickerVIewGenerator(label: "Report Type")
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    private func pickerVIewGenerator(label:String){
        self.status = false
        let alertView = UIAlertController(
            title: "Select \(label)",
            message: "\n\n\n\n\n\n\n",
            preferredStyle: .alert)
        
        let pickerView = UIPickerView(frame:
            CGRect(x: 0, y: 50, width: 260, height: 130))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        alertView.view.addSubview(pickerView)
        
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if self.status == false{
                if self.pickerChoice == self.pickerViewCityGroups{
                    self.filterChoiceCity = "All"
                }else if self.pickerChoice == self.pickerViewReportStatusGroups{
                    self.filterChoiceReportStatus = "All"
                }
            }
            self.loadData()
            self.complaintsTableView.reloadData()
        }))
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(alertView, animated: true, completion: {
            pickerView.frame.size.width = alertView.view.frame.size.width
        })
    }
    
}

extension ComplaintsViewController{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewCityGroups[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewCityGroups.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.status = true
        if self.pickerChoice == self.pickerViewCityGroups{
            self.filterChoiceCity = self.pickerChoice[row]
        }else{
            self.filterChoiceReportStatus = self.pickerChoice[row]
        }
    }
    
    private func _loader() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.gray
        textLabel.text = "Deleting..."
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }
    
    @objc func loadData(){
        if (self.filterChoiceCity == "All" && self.filterChoiceReportStatus == "All" && staticLinker.userInformation.userType == "admin") || (self.filterChoiceCity == "All" && staticLinker.userInformation.userType == "user"){
            self.filterStatus = false
        }else{
            self.filterStatus = true
            if self.filterChoiceCity == "All"{
                self.filterChoiceCity = nil
            }
            if self.filterChoiceReportStatus == "All"{
                self.filterChoiceReportStatus = nil
            }
            gsdDataObj.getComplaintsReports(filter1: self.filterChoiceCity, filter2: self.filterChoiceReportStatus, completion: {(error, crimeData) in
                DispatchQueue.main.async {
                    self.refreshControl.beginRefreshing()
                    if let err = error{
                        self.msg = err
                        self.complaintsDataList = nil
                        self.complaintsTableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }else{
                        self.refreshControl.endRefreshing()
                        if crimeData != nil{
                            self.complaintsDataList = crimeData
                            self.complaintsTableView.reloadData()
                        }else{
                            self.msg = "No Crime Reports"
                            self.complaintsDataList = nil
                            self.complaintsTableView.reloadData()
                        }
                    }
                    if self.complaintsDataList != nil{
                        self.tabBarBadge.badgeValue = String(self.complaintsDataList.count)
                        self.tabBarBadge.badgeColor = .black
                    }else{
                        self.tabBarBadge.badgeValue = "0"
                        self.tabBarBadge.badgeColor = .red
                    }
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filterStatus == false{
            self.data = self.complaintsDataListListner[indexPath.row]
        }else{
            self.data = self.complaintsDataList[indexPath.row]
        }
        if staticLinker.userInformation.userType == "user"{
            self.performSegue(withIdentifier: "showComplaintsUser", sender: self)
        }else{
            self.performSegue(withIdentifier: "showComplaintsAdmin", sender: self)
        }
        self.complaintsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showComplaintsUser"{
            let viewTodocontroller = segue.destination as? ReportDetailsUserViewController
            viewTodocontroller!.report = self.data
            
        }else if segue.identifier == "showComplaintsAdmin"{
            let viewTodocontroller = segue.destination as? ReportDetailsAdminViewController
            viewTodocontroller?.delegate = self
            viewTodocontroller!.report = self.data
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        
        if self.complaintsDataListListner != nil {
            self.complaintsTableView.tableFooterView = UIView()
            numOfSection = 1
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.complaintsTableView.bounds.size.width, height: self.complaintsTableView.bounds.size.height))
            noDataLabel.text = msg
            noDataLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.complaintsTableView.tableFooterView = noDataLabel
            
        }
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterStatus == false{
            return complaintsDataListListner.count
        }else{
            return complaintsDataList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.complaintsTableView.dequeueReusableCell(withIdentifier: "reportsCell") as! ReportsTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        if filterStatus == false{
            cell.title.text = self.complaintsDataListListner[indexPath.row].title
            cell.city.text = self.complaintsDataListListner[indexPath.row].city
            switch self.complaintsDataListListner[indexPath.row].status{
            case "Pending":
                cell.profileImage.borderColor = .yellow
            case "Inprogress":
                cell.profileImage.borderColor = .blue
            case "Completed":
                cell.profileImage.borderColor = .green
            default:
                cell.profileImage.borderColor = .red
            }
            if self.complaintsDataListListner[indexPath.row].imgUrl != ""{
                URLSession.shared.dataTask( with: URL(string: self.complaintsDataListListner[indexPath.row].imgUrl)!, completionHandler: {
                    (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        if let data = data {
                            let loader = UIActivityIndicatorView(style: .gray)
                            loader.hidesWhenStopped = true
                            loader.startAnimating()
                            cell.loader.stopAnimating()
                            cell.profileImage.image = UIImage(data: data)
                        }
                    }
                }).resume()
            }
        }else{
            cell.title.text = self.complaintsDataList[indexPath.row].title
            cell.city.text = self.complaintsDataList[indexPath.row].city
            switch self.complaintsDataList[indexPath.row].status{
            case "Pending":
                cell.profileImage.borderColor = .yellow
            case "Inprogress":
                cell.profileImage.borderColor = .blue
            case "Completed":
                cell.profileImage.borderColor = .green
            default:
                cell.profileImage.borderColor = .red
            }
            if self.complaintsDataList[indexPath.row].imgUrl != ""{
                URLSession.shared.dataTask( with: URL(string: self.complaintsDataList[indexPath.row].imgUrl)!, completionHandler: {
                    (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        if let data = data {
                            let loader = UIActivityIndicatorView(style: .gray)
                            loader.hidesWhenStopped = true
                            loader.startAnimating()
                            cell.loader.stopAnimating()
                            cell.profileImage.image = UIImage(data: data)
                        }
                    }
                }).resume()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:  UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete selected item?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                self._loader()
                if self.filterStatus == false{
                    self.gsdDataObj.deleteReport(id: self.complaintsDataListListner[indexPath.row].reportId, completion: {(_) in
                        self.boxView.removeFromSuperview()
                        self.loadData()
                    })
                }else{
                    self.gsdDataObj.deleteReport(id: self.complaintsDataList[indexPath.row].reportId, completion: {(_) in
                        self.boxView.removeFromSuperview()
                        self.loadData()
                    })
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}