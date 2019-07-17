//
//  ViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: textFieldDesign!
    @IBOutlet weak var passwordField: textFieldDesign!
    @IBOutlet weak var signBtnOut: ButtonDesign!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var loginObj:loginRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.isHidden = true
        self.loader.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBAction func signInBtn(_ sender: Any) {
        self.loader.startAnimating()
        self.signBtnOut.isEnabled = false
        self.emailField.text = "kashifrizwan3857@gmail.com"
        self.passwordField.text = "qwerty"
        if let email = self.emailField.text, let password = self.passwordField.text{
            self.loginObj = loginRequest(email: email, password: password)
            self.loginObj.loginRequest(completion: {(error, isLogin) in
                self.loader.stopAnimating()
                self.signBtnOut.isEnabled = true
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Success", message: "You are logged into your account.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
                        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let centerVC = mainStoryBoard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
                        // setting the login status to true
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        appDel.window!.rootViewController = centerVC
                        appDel.window!.makeKeyAndVisible()
                        //self.performSegue(withIdentifier: "fromLogin", sender: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

