//
//  SideMenuViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/19/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    var userMenu:[[String]]!
    var userChoice = [["User"],["Dashboard","File A Report"]]//,"View My Reports"]]
    var adminChoice = [["Admin"],["Dashboard"]]
    var imageNames = ["dashboard","add","view"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        if staticLinker.userInformation.userType == "user"{
            self.userMenu = self.userChoice
        }else{
            self.userMenu = self.adminChoice
        }
    }
}

extension SideMenuViewController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 && indexPath.row == 0{
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.section != 0 && indexPath.row == 1{
            self.performSegue(withIdentifier: "fileReport", sender: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.userMenu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userMenu[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! ProfileTableViewCell
            if staticLinker.userInformation.image != ""{
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
            cell.userName.text = staticLinker.userInformation.name
            cell.userType.text = staticLinker.userInformation.userType
            return cell
        }else{
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as! MenuTableViewCell
            cell.name.text = self.userChoice[indexPath.section][indexPath.row]
            cell.menuImage.image = UIImage(named: self.imageNames[indexPath.row])
            return cell
        }
    }
    
}
