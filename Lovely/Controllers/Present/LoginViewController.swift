//
//  LoginViewController.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import UserNotifications

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var forgotPasswordLbl: UILabel!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var haveAccountLbl: UILabel!
    
    var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configKeyboard()
        
        emailTextFiled.delegate = self
        passwordTextFiled.delegate = self
        
        let tapToSignup = UITapGestureRecognizer(target: self, action: #selector(goToSignup))
        haveAccountLbl.isUserInteractionEnabled = true
        haveAccountLbl.addGestureRecognizer(tapToSignup)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if _UserDefault.get(key: .token) != nil {
            navigateToHome()
        }
    }
    
    @objc func goToSignup(sender: UITapGestureRecognizer){
        guard let registerVC = getVC(RegisterViewController.self) else {return}
        navigationController?.pushViewController(registerVC, animated: true)
    }
    @IBAction func skipHandle(_ sender: UIButton) {
        navigateToHome()
    }
    
    private func setupUI(){
        setHideNavigation()
        emailTextFiled.text = "viettqpd03249@fpt.edu.vn"
        passwordTextFiled.text = "khoqua226"
        
        signinBtn.backgroundColor = Colors.red_start.value
        signinBtn.addCorner(corners: .all, radius: 20, width: 1, color: .red)
        signinBtn.addShadow(color: Colors.red_start.value, offset: CGSize(width: 0, height: 8), opacity: 0.4, radius: 8)
    }
    
    @objc func dissmissHandle(){
        view.endEditing(true)
    }
    
    private func configKeyboard(){
        let dissmissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissHandle))
        view.addGestureRecognizer(dissmissKeyboard)
    }
    
    private func navigateToHome(){
        let tabBarVC = TabBarController()
        self.present(tabBarVC, animated: false)
    }
    
    @IBAction func signinHandle(_ sender: UIButton) {
        let email = emailTextFiled.text ?? ""
        let password = passwordTextFiled.text ?? ""
        
        let validate = getValidate(email: email, password: password)
        
        if validate.isEmpty {
            addLoadingView()
            networkManager.login(email: email, password: password) { (response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showAlert_error(error)
                    }
                    if let response = response {
                        if response.status {
                            _UserDefault.set(key: .token, value: response.data!.authToken)
                            _UserDefault.set(key: .userId, value: response.data!.user!.id)
                            NotificationCenter.default.post(name: Notification.Name.login, object: nil)
                            self.navigateToHome()
                        } else {
                            self.showValidate(of: response)
                        }
                    }
                    let _ = self.removeLoadingView()
                }
            }
        } else {
            let _ = self.removeLoadingView()
            self.showAlert_error(validate)
        }
    }
    @IBAction func facebookHandle(_ sender: UIButton) {
    }
    @IBAction func googleHandle(_ sender: UIButton) {
        print("Google")
    }
    @IBAction func showPasswordHandle(_ sender: UIButton) {
        passwordTextFiled.isSecureTextEntry = !passwordTextFiled.isSecureTextEntry
        if passwordTextFiled.isSecureTextEntry == true {
            showPasswordBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            showPasswordBtn.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    private func getValidate(email: String?, password: String?) -> String {
        let us = email ?? ""
        let pas = password ?? ""
        
        if us.isEmpty || pas.isEmpty {
            return "Vui lòng không để trống"
        } else {
            if pas.count < 6 {
                return "Mật khẩu phải lớn hơn hoặc bằng 6 kí tự"
            }
        }
        return ""
    }
    
    private func showValidate(of error: UserAPI?) {
        guard let error = error else {
            showAlert_error()
            return
        }
        switch error.code {
        case 1001, 1003, 1004:
            showAlert_error(error.messages)
        case 1002, 1005, 1006:
            showAlert_error(error.messages)
        case 1007, 1008, 1009:
            showAlert_error(error.messages)
        default:
            showAlert_error(error.messages)
        }
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
}
