//
//  DataUserDefault.swift
//  Lovely
//
//  Created by MacOS on 8/30/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

enum KeyData {
    case walkthrought
    case token
    case userId
    
    var string: String {
        switch self {
        case .walkthrought:
            return "walkthrought"
        case .token:
            return "token"
        case .userId:
            return "userId"
        }
    }
}

struct _UserDefault {
    static func get(key: KeyData) -> Any? {
        guard let value = UserDefaults.standard.object(forKey: key.string) else {
            return nil
        }
        return value
    }
    
    static func set(key: KeyData, value: Any) {
        UserDefaults.standard.set(value, forKey: key.string)
    }
    
    static func remove(key: KeyData) {
        UserDefaults.standard.removeObject(forKey: key.string)
    }
    
    static func removeAll() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removeVolatileDomain(forName: appDomain)
        }
    }
}
