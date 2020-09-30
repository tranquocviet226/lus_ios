//
//  RoomInfo.swift
//  Lovely
//
//  Created by MacOS on 9/19/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

struct RoomInfo {
    let roomId: String
    let userIdReceive: String
    let nameReceive: String
}

extension RoomInfo: Decodable {
    private enum RoomInfoCodingKeys: String, CodingKey {
        case roomId
        case userIdReceive
        case nameReceive = "name"
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: RoomInfoCodingKeys.self)
        
        roomId = try entity.decode(String.self, forKey: .roomId)
        userIdReceive = try entity.decode(String.self, forKey: .userIdReceive)
        nameReceive = try entity.decode(String.self, forKey: .nameReceive)
    }
}

struct RoomAvailable {
    let status: Bool
    let roomId: String
}
extension RoomAvailable: Decodable {
    private enum RoomAvailableCodingKeys: String, CodingKey {
        case status
        case roomId
    }
    init(from decoder: Decoder) throws {
        let entity = try decoder.container(keyedBy: RoomAvailableCodingKeys.self)
        
        status = try entity.decode(Bool.self, forKey: .status)
        roomId = try entity.decode(String.self, forKey: .roomId)
    }
}
