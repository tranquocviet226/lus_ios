//
//  LoginProfileViewController.swift
//  Lovely
//
//  Created by MacOS on 9/4/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class LoginProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI(){
        setHideNavigation()
        setupBackground()
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
    }
}
