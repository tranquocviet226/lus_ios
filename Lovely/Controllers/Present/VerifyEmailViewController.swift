//
//  VerifyEmailViewController.swift
//  Lovely
//
//  Created by MacOS on 9/2/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class VerifyEmailViewController: UIViewController {
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!
    @IBOutlet weak var number4: UITextField!
    @IBOutlet weak var number5: UITextField!
    @IBOutlet weak var number6: UITextField!
    
    var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    var id: String!
    var email: String!
    var password: String!
    var username: String!
    var phone: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configKeyboard()
        KeyboardAvoiding.avoidingView = self.view
    }
    
    func setupUI() {
        setupBackground()
        setHideNavigation()
        setupNavigation(isBack: true)
        
        verifyBtn.backgroundColor = Colors.red_start.value
        verifyBtn.addCorner(corners: .all, radius: 20, width: 1, color: .red)
        verifyBtn.addShadow(color: Colors.red_start.value, offset: CGSize(width: 0, height: 8), opacity: 0.4, radius: 8)
        
        
    }
    
    @objc func dissmissHandle(){
        view.endEditing(true)
    }
    
    private func configKeyboard(){
        let dissmissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissHandle))
        view.addGestureRecognizer(dissmissKeyboard)
    }
    
    private func navigateToLogin(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func verifyHandle(_ sender: UIButton) {
        let num1 = number1.text ?? ""
        let num2 = number2.text ?? ""
        let num3 = number3.text ?? ""
        let num4 = number4.text ?? ""
        let num5 = number5.text ?? ""
        let num6 = number6.text ?? ""
        
        let num = num1 + num2 + num3 + num4 + num5 + num6
        
        addLoadingView()
        networkManager.register(id: id, code: num, email: email, password: password, username: username, phone: Int(phone)) { (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    if response.status {
                        _UserDefault.set(key: .token, value: response.data!.authToken)
                        self.navigateToLogin()
                    } else {
                        self.showAlert_error(response.messages)
                    }
                }
                let _ = self.removeLoadingView()
            }
        }
    }
}
