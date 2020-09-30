//
//  ViewController.swift
//  Lovely
//
//  Created by MacOS on 8/25/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTitle()
        animationView()
        
        subTitleLabel.addTextSpacing(spacing: 2)
        
        //Socket IO
        SocketHelper.shared.connectSocket{ (success) in
        }
        
    }
    
    private func loadTitle(){
        titleLabel.text = ""
        subTitleLabel.text = ""
        
        let titleTxt = Constants.appName
        let subTitleTxt = "Thế giới tình yêu"
        var index = 0
        
        for letter in titleTxt {
            Timer.scheduledTimer(withTimeInterval: 0.15 * Double(index), repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            index += 1
        }
        
        for letter in subTitleTxt {
            Timer.scheduledTimer(withTimeInterval: 0.05 * Double(index), repeats: false) { (timer) in
                self.subTitleLabel.text?.append(letter)
            }
            index += 1
        }
    }
    
    private func animationView(){
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseInOut, animations: {
            self.imgLogo.alpha = 0.0
            self.titleLabel.alpha = 0.0
            self.subTitleLabel.alpha = 0.0
        }, completion: {(finished) in
            if finished {
                self.nextScreen()
            }
        })
    }
    
    private func nextScreen(){
        if _UserDefault.get(key: .walkthrought) != nil {
            guard let loginNavigation = getVC(LoginNavigationController.self) else {return}
            self.present(loginNavigation, animated: false)
        } else{
            guard let walkthroughVC = getVC(WalkthroughViewController.self) else {return}
            self.present(walkthroughVC, animated: false)
        }
    }
}

