//
//  SignInViewController.swift
//  GroupTalk
//
//  Created by youngjun goo on 27/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let remoteConfig = RemoteConfig.remoteConfig()
    var colorString: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBar = UIView()
        self.view.addSubview(statusBar)
        statusBar.snp.makeConstraints{ (m) in
            m.right.top.left.equalTo(self.view)
            m.height.equalTo(20)
        }
        colorString = remoteConfig["splash_background"].stringValue
        statusBar.backgroundColor = UIColor(hex: colorString)
        signUpButton.backgroundColor = UIColor(hex: colorString)
        cancelButton.backgroundColor = UIColor(hex: colorString)
        // Do any additional setup after loading the view.
        signUpButton.addTarget(self, action: #selector(signUpCheckEvent), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelEvent), for: .touchUpInside)
    }
    
    @objc func signUpCheckEvent() {
        
        guard let _ = emailTextField.text else {
            print("email text 누락")
            return
        }
        guard let _ = pwdTextField.text else {
            print("pwd text 누락")
            return
        }
        guard let _ = nameTextField.text else {
            print("name text 누락")
            return
        }
        
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: pwdTextField.text!) { (user, err) in
            guard let userID = Auth.auth().currentUser?.uid else { return }
            Database.database().reference().child("users").child(userID).setValue(["name": self.nameTextField.text!])
        }
    }
    
    @objc func cancelEvent() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}