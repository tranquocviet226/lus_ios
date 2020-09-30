//
//  Message.swift
//  Lovely
//
//  Created by MacOS on 9/14/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

struct RoomAPI {
    let success: Bool
    let data: Room?
    let status_code: Int
    let messages: String
}
extension RoomAPI: Decodable {
    private enum RoomAPICodingKeys: String, CodingKey {
        case success
        case data
        case status_code
        case messages
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: RoomAPICodingKeys.self)
        
        success = try entity.decode(Bool.self, forKey: .success)
        data = try entity.decode(Room.self, forKey: .data)
        status_code = try entity.decode(Int.self, forKey: .status_code)
        messages = try entity.decode(String.self, forKey: .messages)
    }
}

struct Room {
    let userIdSend: String
    let userNameSend: String
    let userIdReceive: String
    let userNameReceive: String
    let roomId: String?
}
extension Room: Decodable {
    private enum RoomCodingKeys: String, CodingKey {
        case userIdSend
        case userNameSend
        case userIdReceive
        case userNameReceive
        case roomId
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: RoomCodingKeys.self)
        
        userIdSend = try entity.decode(String.self, forKey: .userIdSend)
        userNameSend = try entity.decode(String.self, forKey: .userNameSend)
        userIdReceive = try entity.decode(String.self, forKey: .userIdReceive)
        userNameReceive = try entity.decode(String.self, forKey: .userNameReceive)
        roomId = try? entity.decode(String.self, forKey: .roomId)
    }
}

struct Message {
    let roomId: String
    let userIdSend: String
    let userIdReceive: String
    let content: String
}
extension Message: Decodable {
    private enum MessageCodingKeys: String, CodingKey {
        case roomId
        case userIdSend
        case userIdReceive
        case content
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: MessageCodingKeys.self)
        
        roomId = try entity.decode(String.self, forKey: .roomId)
        userIdSend = try entity.decode(String.self, forKey: .userIdSend)
        userIdReceive = try entity.decode(String.self, forKey: .userIdReceive)
        content = try entity.decode(String.self, forKey: .content)
    }
}
