//
//  MissingPersonsViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/24/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class MissingPersonsViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var missingPersonsTableView: UITableView!
    private var missingPersonsDataList:[report]!
    private var msg = "Loading..."
    var refreshControl = UIRefreshControl()
    var boxView = UIView()
    var data:report!
    var gsdDataObj = gsdData()
    let EmptyView = UIView()
    var filterChoice:String? = "All"
    let pickerViewCityGroups=["Any","Karachi","Lahore","Islamabad","Rawalpindi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.missingPersonsTableView.delegate = self
        self.missingPersonsTableView.dataSource = self
        self.missingPersonsTableView.separatorColor = .black
        self.missingPersonsTableView.layoutMargins = UIEdgeInsets.zero
        self.missingPersonsTableView.separatorInset = UIEdgeInsets.zero
        self.loadData()
        missingPersonsTableView.rowHeight = UITableView.automaticDimension
        missingPersonsTableView.estimatedRowHeight = 108
        missingPersonsTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    @IBAction func filter(_ sender: Any) {
        self.filterChoice = "All"
        let alertView = UIAlertController(
            title: "Select City",
            message: "\n\n\n\n\n\n\n",
            preferredStyle: .alert)
        
        let pickerView = UIPickerView(frame:
            CGRect(x: 0, y: 50, width: 260, height: 162))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        alertView.view.addSubview(pickerView)
        
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.loadData()
            self.missingPersonsTableView.reloadData()
        }))
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(alertView, animated: true, completion: {
            pickerView.frame.size.width = alertView.view.frame.size.width
        })
    }
    
}

extension MissingPersonsViewController{
    
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
        self.filterChoice = pickerViewCityGroups[row]
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
        if self.filterChoice == "All"{
            self.filterChoice = nil
        }
        gsdDataObj.getMissingReports(filter: self.filterChoice, completion: {(error, crimeData) in
            DispatchQueue.main.async {
                self.refreshControl.beginRefreshing()
                self.filterChoice = "All"
                if let err = error{
                    self.msg = err
                    self.missingPersonsDataList = nil
                    self.missingPersonsTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }else{
                    self.refreshControl.endRefreshing()
                    if crimeData != nil{
                        self.missingPersonsDataList = crimeData
                        self.missingPersonsTableView.reloadData()
                    }else{
                        self.msg = "No Crime Reports"
                        self.missingPersonsDataList = nil
                        self.missingPersonsTableView.reloadData()
                    }
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.data = self.missingPersonsDataList[indexPath.row]
        //self.performSegue(withIdentifier: "viewTodo", sender: self)
        self.missingPersonsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewTodo"{
            //let viewTodocontroller = segue.destination as? EditToDoViewController
            //viewTodocontroller!.data = self.data
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        
        if self.missingPersonsDataList != nil {
            self.missingPersonsTableView.tableFooterView = UIView()
            numOfSection = 1
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.missingPersonsTableView.bounds.size.width, height: self.missingPersonsTableView.bounds.size.height))
            noDataLabel.text = msg
            noDataLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.missingPersonsTableView.tableFooterView = noDataLabel
            
        }
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missingPersonsDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportsCell") as! ReportsTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.title.text = self.missingPersonsDataList[indexPath.row].title
        cell.city.text = self.missingPersonsDataList[indexPath.row].city
        if self.missingPersonsDataList[indexPath.row].imgUrl != ""{
            if let image = staticLinker.img{
                cell.loader.stopAnimating()
                cell.profileImage.image = image
            }else{
                URLSession.shared.dataTask( with: NSURL(string: staticLinker.userInformation.image)! as URL, completionHandler: {
                    (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        if let data = data {
                            let loader = UIActivityIndicatorView(style: .gray)
                            loader.hidesWhenStopped = true
                            loader.startAnimating()
                            cell.loader.stopAnimating()
                            cell.profileImage.image = UIImage(data: data)
                            staticLinker.img = cell.profileImage.image
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
                self.gsdDataObj.deleteReport(id: self.missingPersonsDataList[indexPath.row].reportId, completion: {(_) in
                    self.boxView.removeFromSuperview()
                    self.loadData()
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}