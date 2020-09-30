//
//  ExtendTypeDefault.swift
//  Lovely
//
//  Created by MacOS on 8/26/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func setSizeFont(_ fontName: String? = nil, style: StringStyle = .regular, size: CGFloat = 17, color: Colors? = nil, underline: Bool = false, kern: Double = 0, tracking: Bool = false, paragraphStyle: Bool = false) -> NSAttributedString {
        
        let font = UIFont(name: fontName != nil ? fontName! : "OpenSans-\(style.rawValue)", size: ScaleScreen.device.sizeFont + size)
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = font
        if let color = color {
            attributes[.foregroundColor] = color.value
        }
        if underline {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        if kern != 0 {
            attributes[.kern] = kern
        }
        if tracking {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = size / 4
            attributes[.paragraphStyle] = paragraphStyle
        }
        
        return NSAttributedString(string: self, attributes: attributes)
    }
}

extension UILabel {
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: self.text!.count))
        self.attributedText = attributedString
    }
}

class PaddingLabel: UILabel {
    
    var insets = UIEdgeInsets.zero
    
    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }
    }
}

extension UITableViewCell {
    func getTVC<T>(_ viewType: T.Type) -> T? {
        let identifier = String(describing: viewType)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}

extension UIViewController {
    func setupBackground(_ named: String = "background") {
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: ScaleScreen.width, height: ScaleScreen.height))
        background.image = UIImage(named: named)
        background.contentMode = .scaleAspectFill
        background.alpha = 0.8
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
    }
    
    func getVC<T>(_ viewType: T.Type) -> T? {
        let identifier = String(describing: viewType)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
    
    func addLoadingView(apiCount: Int = 1) {
        if let loadingView = self.view.viewWithTag(Utils.Key.Code.LOADING_VIEW) as? LoadingView {
            loadingView.apiCount += 1
        } else {
            let frameView = CGRect(x: 0, y: 0 , width: ScaleScreen.width, height: ScaleScreen.height)
            let loadingView: LoadingView = LoadingView(frame: frameView)
            loadingView.apiCount = apiCount
            loadingView.tag = Utils.Key.Code.LOADING_VIEW
            self.view.addSubview(loadingView)
        }
    }
    
    func removeLoadingView() -> Bool {
        guard let loadingView = self.view.viewWithTag(Utils.Key.Code.LOADING_VIEW) as? LoadingView else { return false }
        loadingView.apiCount -= 1
        if loadingView.apiCount == 0 {
            loadingView.removeFromSuperview()
            return true
        }
        
        return false
    }
    
    func setHideNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showAlert_error(_ message: String? = Localizable.Error.Internet.localized, _ reload: Bool = false) {
        //        let mess = message == Localizable.Error.Internet.localized ? Localizable.Error.Internet.localized : Localizable.Error.ApiError.localized
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        if reload {
            let actionReload = UIAlertAction(title: "Reload", style: .default) { (action) in
                self.handlerReloadAPI(alert: action)
            }
            alertController.addAction(actionReload)
        }
        let actionCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true)
    }
    
    @objc func handlerReloadAPI(alert: UIAlertAction) {
        // Xử lý request API
        print("Reload API")
    }
    
    @objc func backNavigation(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func backPresenting(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func setupNavigation(title: String = "", isBack: Bool = false, isPresent: Bool = false) {
        if let navigation = self.view.subviews[1] as? NavigationView {
            if isPresent {
                navigation.backButton.addTarget(self, action: #selector(backPresenting), for: .touchUpInside)
            } else {
                navigation.backButton.addTarget(self, action: #selector(backNavigation), for: .touchUpInside)
            }
            navigation.backButton.isHidden = !isBack
        }
    }
}

extension UIView {
    func addCornerAndShadow(corners: cornerView = .all, radius: CGFloat = -1, width: CGFloat = 0, color: UIColor = .clear) {
        self.addShadowOnly(corners: corners, radius: radius)
        self.addCorner(corners: corners, radius: radius, width: width, color: color)
    }
    func addCorner(corners: cornerView = .all, radius: CGFloat = -1, width: CGFloat = 0, color: UIColor = .clear) {
        let cornerRadius: CGFloat = self.cornerRadius(radius)
        if corners == .all {
            self.layer.cornerRadius = cornerRadius
            self.layer.borderWidth = width
            self.layer.borderColor = color.cgColor
            self.clipsToBounds = true
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners.rect!, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
            
            let borderLayer = CAShapeLayer()
            borderLayer.frame = self.bounds
            borderLayer.path = maskLayer.path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = color.cgColor
            borderLayer.lineWidth = width
            self.layer.addSublayer(borderLayer)
        }
    }
    
    func addShadowOnly(corners: cornerView = .all, radius: CGFloat = -1, color: UIColor = Colors.red_start.value) {
        let cornerRadius: CGFloat = self.cornerRadius(radius)
        if let shadow = self.superview?.viewWithTag(self.tag + 1) {
            if corners == .all {
                shadow.layer.cornerRadius = cornerRadius
                shadow.layer.frame = self.bounds
                shadow.layer.backgroundColor = UIColor.white.cgColor
            } else {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners.rect!, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                shadow.layer.shadowPath = path.cgPath
                shadow.layer.backgroundColor = UIColor.clear.cgColor
            }
        } else {
            self.tag = Utils.Key.Code.SHADOW_VIEW
            let shadow = UIView()
            
            if corners == .all {
                shadow.layer.cornerRadius = cornerRadius
                shadow.layer.frame = self.bounds
                shadow.layer.backgroundColor = UIColor.white.cgColor
            } else {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners.rect!, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                shadow.layer.shadowPath = path.cgPath
                shadow.layer.backgroundColor = UIColor.clear.cgColor
            }
            
            shadow.layer.shadowColor = color.cgColor
            shadow.layer.shadowOffset = CGSize(width: 0, height: 2)
            shadow.layer.shadowRadius = 2
            shadow.layer.shadowOpacity = 0.2
            shadow.isHidden = self.isHidden
            shadow.tag = self.tag + 1
            
            self.layoutIfNeeded()
            self.superview?.insertSubview(shadow, belowSubview: self)
            shadow.translatesAutoresizingMaskIntoConstraints = false
            shadow.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            shadow.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            shadow.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            shadow.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            Utils.Key.Code.SHADOW_VIEW += 2
        }
    }
    
    func cornerRadius(_ radius: CGFloat) -> CGFloat {
        var cornerRadius: CGFloat = radius
        if radius == -1 {
            if self.frame.width <= self.frame.height {
                cornerRadius = self.frame.width / 2
            } else {
                cornerRadius = self.frame.height / 2
            }
        }
        return cornerRadius
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addShadow(color: UIColor = Colors.red_start.value, offset: CGSize = CGSize(width: 0, height: 3), opacity: Float = 0.7, radius: CGFloat = 5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
}


extension UIImage {
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
            
        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }
        
        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = opaque
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return newImage
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hex: String?) {
        var hexSanitized = hex?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0"
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        if let rgb = Int(hexSanitized, radix: 16) {
            self.init(rgb: rgb)
        } else {
            self.init(red: 0, green: 0, blue: 0, a: 0)
        }
    }
}
