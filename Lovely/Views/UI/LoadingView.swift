//
//  LoadingView.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class LoadingView: UIView {
    
    var apiCount: Int = {
        return 1
    }()
    
    var imageGif: UIImageView = {
        let imageGif = UIImageView(frame: CGRect(x: 0, y: 0, width: ScaleScreen.width*06, height: ScaleScreen.width*0.313))
        imageGif.loadGif(asset: "love_loading2")
        imageGif.contentMode = .scaleAspectFit
        
        return imageGif
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        imageGif.center.x = self.frame.width/2
        imageGif.center.y = self.frame.height/2
        
        backgroundColor = Colors.loading.value
        self.addSubview(imageGif)
    }
}
