//
//  ReportsViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/29/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class ReportsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
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
