//
//  NavigationView.swift
//  Lovely
//
//  Created by MacOS on 8/28/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    
    let backButton = UIButton()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 8
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = Colors.red_start.value
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        backButton.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        backButton.addShadow(opacity: 0.3, radius: 3)
        
        self.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.backgroundColor = .clear
        self.updateConstraints()
    }
    
}
