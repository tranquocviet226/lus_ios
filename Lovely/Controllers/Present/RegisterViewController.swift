//
//  RegisterViewController.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class RegisterViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var haveAccountLabel: UILabel!
    
    var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTextField()
        configKeyboard()
        setupUI()
        KeyboardAvoiding.avoidingView = self.view
        
    }
    
    private func delegateTextField(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmationTextField.delegate = self
        fullnameTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    @objc func dissmissHandle(){
        view.endEditing(true)
    }
    
    private func configKeyboard(){
        let dissmissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissHandle))
        view.addGestureRecognizer(dissmissKeyboard)
    }
    
    private func setupUI(){
        setupBackground()
        setHideNavigation()
        setupNavigation(isBack: true)
        
        signupBtn.backgroundColor = Colors.red_start.value
        signupBtn.addCorner(corners: .all, radius: 20, width: 1, color: .red)
        signupBtn.addShadow(color: Colors.red_start.value, offset: CGSize(width: 0, height: 8), opacity: 0.4, radius: 8)
        phoneTextField.keyboardType = .numberPad
    }
    @IBAction func signupHandle(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordConfirmation = passwordConfirmationTextField.text ?? ""
        let username = fullnameTextField.text ?? ""
        let phone = Int(phoneTextField.text ?? "0")
        
        let validate = getValidate(email: email, password: password, passwordConfirmation: passwordConfirmation, username: username, phone: phone)
        
        addLoadingView()
        if validate.isEmpty {
            networkManager.verifyEmail(email: email){ (response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showValidate(of: error)
                    }
                    if let response = response {
                        if response.status {
                            let id = response.data?.user?.id ?? ""
                            self.navigationToVerify(id: id)
                        } else {
                            self.showValidate(of: response.messages)
                        }
                    }
                    let _ = self.removeLoadingView()
                }
            }
        } else {
            let _ = self.removeLoadingView()
            showValidate(of: validate)
        }
    }
    
    private func navigationToVerify(id: String){
        guard let verifyVC = getVC(VerifyEmailViewController.self) else {return}
        verifyVC.id = id
        verifyVC.email = emailTextField.text
        verifyVC.password = passwordTextField.text
        verifyVC.username = fullnameTextField.text
        verifyVC.phone = phoneTextField.text
        
        navigationController?.pushViewController(verifyVC, animated: true)
    }
    
    private func getValidate(email: String?, password: String?, passwordConfirmation: String?, username: String?, phone: Int?) -> String {
        let us = email ?? ""
        let pas = password ?? ""
        let pasConf = passwordConfirmation ?? ""
        let full = username ?? ""
        let phon = phone ?? 0
        
        if us.isEmpty || pas.isEmpty || full.isEmpty || pasConf.isEmpty || String(phon).isEmpty{
            return "Vui lòng không để trống"
        } else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            
            if emailPred.evaluate(with: us) != true {
                return "Email không hợp lệ"
            } else {
                if pas.count < 6 {
                    return "Mật khẩu phải lớn hơn hoặc bằng 6 kí tự"
                } else if String(phon).count < 10 || String(phon).count > 11{
                    return "Số điện thoại phải từ 10 đến 11 kí tự"
                } else if pas != pasConf {
                    return "Mật khẩu phải trùng khớp"
                }
            }
        }
        return ""
    }
    
    private func showValidate(of error: String?) {
        guard let error = error else {
            showAlert_error()
            return
        }
        showAlert_error(error)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return false
    }
}
