//
//  Utils.swift
//  Lovely
//
//  Created by MacOS on 8/26/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import SDWebImage

class Utils {
    class Common {
        class func getImageScroll(for view: UIScrollView, at index: Int, image: String?, placeholder: String = "Placeholder_StoreInfo") -> UIView {
            var viewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
            viewFrame.origin.x = view.frame.size.width * CGFloat(index)
            viewFrame.size = view.frame.size
            
            let container = UIView(frame: viewFrame)
            let imageView = UIImageView()
            
            container.addSubview(imageView)
            container.clipsToBounds = true
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
            imageView.contentMode = .scaleToFill
            imageView.sd_setImage(with: URL(string: image ?? ""), placeholderImage: UIImage(named: placeholder), completed: { (image, error, cacheType, imageURL) in
                guard let size = image?.size else {
                    imageView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
                    return
                }
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: size.width/size.height).isActive = true
            })
            
            view.addSubview(container)
            
            return imageView
        }
        class func getImageScroll2(for scrollView: UIScrollView, at index: Int, image: String?, placeholder: String = "Placeholder_StoreInfo") {
            scrollView.layoutIfNeeded()
            let width = scrollView.frame.width
            let height = scrollView.frame.height
            
            let img = UIImageView()
            img.sd_setImage(with: URL(string: image ?? ""))
            img.contentMode = .scaleToFill
            img.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
            
            let container = UIStackView(arrangedSubviews: [img])
            container.frame = CGRect(x: width*CGFloat(index), y: 0, width: width, height: height)
            
            scrollView.addSubview(container)
        }
    }
    class Key {
        class Code {
            static let LOADING_VIEW = 81
            static let NO_INTERNET = -1009
            static var SHADOW_VIEW = 1000
        }
    }
}

enum cornerView {
    case top
    case bottom
    case left
    case right
    case all
    
    var rect: UIRectCorner? {
        switch self {
        case .top:
            return [.topLeft, .topRight]
        case .bottom:
            return [.bottomLeft, .bottomRight]
        case .left:
            return [.topLeft, .bottomLeft]
        case .right:
            return [.topRight, .bottomRight]
        case .all:
            return nil
        }
    }
}

enum StringStyle: String {
    case regular = "Regular"
    case bold = "Bold"
    case light = "Light"
}

enum StringSize: CGFloat {
    case small = 12
    case medium = 17
    case large = 22
}
