//
//  SignUpViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

protocol signInFill{
    func fillFields(email:String, password:String)
}

class SignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var name: textFieldDesign!
    @IBOutlet weak var email: textFieldDesign!
    @IBOutlet weak var password: textFieldDesign!
    @IBOutlet weak var signUpOut: ButtonDesign!
    @IBOutlet weak var imageViewOut: UIImageViewRounded!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var signUpObj:SignUpRequest!
    private final var image = UIImage(named: "userProfile")
    private var img:UIImage!
    var signUpDel:signInFill?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.isHidden = true
        self.loader.hidesWhenStopped = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        imageViewOut.isUserInteractionEnabled = true
        imageViewOut.addGestureRecognizer(singleTap)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        self.loader.startAnimating()
        self.signUpOut.isEnabled = false
        if imageViewOut.image == image{
            self.image = nil
        }else{
            self.image = self.imageViewOut.image
        }
        if let email = self.email.text, let password = self.password.text, let name = self.name.text{
            self.signUpObj = SignUpRequest(name: name, email: email, password: password)
            self.signUpObj.signUpRequest(image: self.image,completion: {(error, isLogin) in
                self.loader.stopAnimating()
                self.signUpOut.isEnabled = true
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Success", message: "Your account has been created successfully.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
                        if self.signUpDel != nil{
                            self.signUpDel?.fillFields(email: email, password: password)
                            self.navigationController?.popViewController(animated: true)
                        }
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

extension SignUpViewController{
    
    @objc func tapDetected() {
        self.selectImage()
    }
    
    func selectImage() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Photo", preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: {action in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        })
        let removeAction = UIAlertAction(title: "Remove Photo", style: .default, handler: {action in
            self.imageViewOut.image = self.image
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
        })
        optionMenu.addAction(galleryAction)
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(removeAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageViewOut.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
