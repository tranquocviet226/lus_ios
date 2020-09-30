//
//  Base.swift
//  Lovely
//
//  Created by MacOS on 8/28/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

struct BaseAPI {
    let status: Bool
    let code: Int
    let messages: String
}

extension BaseAPI: Decodable {
    private enum BaseApiCodingKeys: String, CodingKey {
        case status = "success"
        case code = "status_code"
        case messages
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: BaseApiCodingKeys.self)
        
        status = try entity.decode(Bool.self, forKey: .status)
        code = try entity.decode(Int.self, forKey: .code)
        messages = try entity.decode(String.self, forKey: .messages)
    }
}

struct ErrorApi {
    let code: Int
    let message: String
}

extension ErrorApi: Decodable {
    private enum ErrorApiCodingKeys: String, CodingKey {
        case code
        case message = "messages"
    }
    
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: ErrorApiCodingKeys.self)
        
        code = try entity.decode(Int.self, forKey: .code)
        message = try entity.decode(String.self, forKey: .message)
    }
}
