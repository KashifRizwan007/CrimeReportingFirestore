//
//  SideMenuViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/19/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import SideMenu
import FirebaseAuth

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    var userMenu:[[String]]!
    var userChoice = [["User"],["Dashboard","File A Report"],["Sign-Out"]]
    var adminChoice = [["Admin"],["Dashboard","Analytics"],["Sign-Out"]]
    var imageNames = ["Dashboard":"dashboard","Analytics":"analytics","Sign-Out":"signout","File A Report":"add"]

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
        self.menuTableView.reloadData()
    }
}

extension SideMenuViewController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userMenu[indexPath.section][indexPath.row] == "Sign-Out"{
            let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to Sign Out?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: {(_) in
                do {
                    try Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: true, completion: self.logOut)
                } catch let err {
                    let _alert = UIAlertController(title: "Alert", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    _alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(_alert, animated: true, completion: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if userMenu[indexPath.section][indexPath.row] == "Dashboard"{
            self.dismiss(animated: true, completion: nil)
        }else if userMenu[indexPath.section][indexPath.row] == "File A Report"{
            self.performSegue(withIdentifier: "fileReport", sender: nil)
        }else if userMenu[indexPath.section][indexPath.row] == "Analytics"{
            self.performSegue(withIdentifier: "analytics", sender: nil)
        }
    }
    
    func logOut(){
        RouteManager.shared.showLogin()
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
            cell.name.text = self.userMenu[indexPath.section][indexPath.row]
            cell.menuImage.image = UIImage(named: self.imageNames[self.userMenu[indexPath.section][indexPath.row]]!)
            return cell
        }
    }
    
}
