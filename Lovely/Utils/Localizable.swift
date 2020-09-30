//
//  Localizable.swift
//  Lovely
//
//  Created by MacOS on 8/26/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

protocol LocalizableDelegate {
    var rawValue: String { get }        // localize key
    var localized: String { get }
}

extension LocalizableDelegate {
    
    //returns a localized value by specified key located in the specified table
    var localized: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: nil)
    }
}

enum Localizable {
    enum Walkthrough: String, LocalizableDelegate {
        case Slide1
        case Slide2
        case Slide3
        case Slide4
        case SubTitle1
        case SubTitle2
        case SubTitle3
        case SubTitle4
        case Start
    }
    enum TabBar: String, LocalizableDelegate {
        case Home
        case Store
        case Likes
        case Notification
        case Profile
    }
    enum Error: String, LocalizableDelegate {
        case Internet
        case ApiError
    }
}
