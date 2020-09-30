//
//  User.swift
//  Lovely
//
//  Created by MacOS on 8/28/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

struct UserAPI {
    let status: Bool
    let data: User?
    let code: Int
    let messages: String
}

extension UserAPI: Decodable {
    private enum UserApiCodingKeys: String, CodingKey {
        case status = "success"
        case data
        case code = "status_code"
        case messages
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: UserApiCodingKeys.self)
        
        data = try? entity.decode(User.self, forKey: .data)
        status = try entity.decode(Bool.self, forKey: .status)
        code = try entity.decode(Int.self, forKey: .code)
        messages = try entity.decode(String.self, forKey: .messages)
    }
}

struct User {
    let user: UserInfo?
    let authToken: String
    let isAdmin: Bool
}

extension User: Decodable {
    private enum UserCodingKeys: String, CodingKey {
        case user
        case authToken = "auth_token"
        case isAdmin = "is_admin"
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: UserCodingKeys.self)
        
        user = try? entity.decode(UserInfo.self, forKey: .user)
        authToken = try entity.decode(String.self, forKey: .authToken)
        isAdmin = try entity.decode(Bool.self, forKey: .isAdmin)
    }
}

struct UserInfo {
    let id: String
    let username: String?
    let email: String?
    let roleId: Int?
    let active: Bool?
    let image: String?
}

extension UserInfo: Decodable {
    private enum UserInfoApiCodingKeys: String, CodingKey {
        case id = "_id"
        case username = "user_name"
        case email
        case roleId = "role_id"
        case active = "isActive"
        case image = "image_path"
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: UserInfoApiCodingKeys.self)
        
        id = try entity.decode(String.self, forKey: .id)
        username = try? entity.decode(String.self, forKey: .username)
        email = try? entity.decode(String.self, forKey: .email)
        roleId = try? entity.decode(Int.self, forKey: .roleId)
        active = try? entity.decode(Bool.self, forKey: .active)
        image = try? entity.decode(String.self, forKey: .image)
    }
}
