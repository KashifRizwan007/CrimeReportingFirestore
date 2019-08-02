//
//  ReportsViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/29/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import SideMenu

class ReportsViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.topItem?.title = "Crime Reports"
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: (self.view)!)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationController?.navigationBar.topItem?.title = item.title
    }
    @IBAction func menu(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    @IBAction func hello(_ sender: Any) {
        switch self.selectedIndex {
        case 0:
            let vc = self.selectedViewController as! CrimesViewController
            vc.filter()
        case 1:
            let vc = self.selectedViewController as! ComplaintsViewController
            vc.filter()
        default:
            let vc = self.selectedViewController as! MissingPersonsViewController
            vc.filter()
        }
    }
}
