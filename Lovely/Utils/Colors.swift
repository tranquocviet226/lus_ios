//
//  Colors.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

enum Colors {
    case red_start
    case red_end
    case loading
    
    var value: UIColor {
        switch self {
        case .red_start:
            return UIColor(hex: "#f23d3e")
        case .red_end:
            return UIColor(hex: "#fd6e75")
        case .loading:
            return UIColor(white: 1, alpha: 0.70)
        }
    }
}
