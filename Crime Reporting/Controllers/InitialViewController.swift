//
//  InitialViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 8/2/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import SideMenu

class InitialViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuManager.default.menuPresentMode = .viewSlideOut
        SideMenuManager.default.menuAlwaysAnimate = true
    }
    
}
