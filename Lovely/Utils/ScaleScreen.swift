//
//  ScaleScreen.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

enum Device {
    case ipad
    case iphone_default
    case iphone_min
    case iphone_max
}

extension Device {
    
    var sizeFont: CGFloat {
        switch self {
        case .iphone_default:
            return 0
        case .iphone_min:
            return -1
        case .iphone_max:
            return 1
        case .ipad:
            return 2
        }
    }
}

struct ScaleScreen {
    static let width: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    static let height: CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    static let addHeightTabBar: CGFloat = {
        return 10
    }()
    
    static let device: Device = {
        if width == 320 {
            return .iphone_min
        } else if width == 375 {
            return .iphone_default
        } else if width == 414 {
            return.iphone_max
        } else if (UIDevice.current.userInterfaceIdiom == .pad) {
            return .ipad
        } else {
            return .iphone_default
        }
    }()
}

