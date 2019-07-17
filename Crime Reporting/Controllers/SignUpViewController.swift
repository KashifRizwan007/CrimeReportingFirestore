//
//  SignUpViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var name: textFieldDesign!
    @IBOutlet weak var email: textFieldDesign!
    @IBOutlet weak var password: textFieldDesign!
    @IBOutlet weak var signUpOut: ButtonDesign!
    @IBOutlet weak var imageViewOut: UIImageViewRounded!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var signUpObj:SignUpRequest!
    private var image = UIImage(named: "background.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.isHidden = true
        self.loader.hidesWhenStopped = true
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
    }
    
}
