//
//  ProfileViewController.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import SocketIO

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if _UserDefault.get(key: .token) == nil {
            guard let loginProfileVC = getVC(LoginProfileViewController.self) else { return }
            
            navigationController?.pushViewController(loginProfileVC, animated: false)
        }
        
        setupUI()
    }
    
    private func setupUI(){
        setHideNavigation()
        setupBackground()
    }
    
    @IBAction func chatHandle(_ sender: UIButton) {
        _UserDefault.remove(key: .token)
        _UserDefault.remove(key: .userId)
        self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
    }
}

