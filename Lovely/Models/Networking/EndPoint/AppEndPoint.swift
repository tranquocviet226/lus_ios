//
//  AppEndPoint.swift
//  Lovely
//
//  Created by MacOS on 8/28/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case dev
    case production
}

public enum AppAPI {
    case LoginId(_ email: String, _ password: String)
    case VerifyEmail(_ email: String)
    case Register(_ id: String, _ code: String, _ email: String, _ password: String, _ username: String, _ phone: Int?)
    case UserInfo(_ id: String)
    case AllRoom(_ userId: String)
    case CheckRoom(_ userIdSend: String, _ userIdReceive: String)
    case Room(_ userIdSend: String, _ userIdReceive: String)
    case Message(_ roomId: String)
}

extension AppAPI: EndPointType {
    static var environmentBaseURL: String {
        switch NetworkManager.enviroment {
        case .dev:
            return Constants.httpUrl
        default:
            return Constants.httpUrl
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: "\(AppAPI.environmentBaseURL)api/v1/") else {
            fatalError("BaseURL could not be configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .LoginId:
            return "user/login"
        case .VerifyEmail:
            return "user/verify_email"
        case .Register:
            return "user/register"
        case .UserInfo:
            return "user/information"
        case .AllRoom:
            return "message/loadAllRoom"
        case .Room:
            return "message/createRoom"
        case .Message:
            return "message/detail"
        case .CheckRoom:
            return "message/checkRoomAvailable"
            
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .LoginId:
            return .post
        case .VerifyEmail:
            return .post
        case .Register:
            return .post
        case .AllRoom:
            return .post
        case .Room:
            return .post
        case .Message:
            return .post
        case .CheckRoom:
            return .post
        case .UserInfo:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .LoginId(let email, let password):
            return .requestParameters(bodyParameters: ["email": email, "password": password], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        case .VerifyEmail(let email):
            return .requestParameters(bodyParameters: ["email": email], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        case .Register(let id, let code, let email, let password, let username, let phone):
            return .requestParameters(bodyParameters: ["id": id, "confirm_email_code": code, "email": email, "password": password, "user_name": username, "phone": phone], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        case .AllRoom(let userId):
            return .requestParameters(bodyParameters: ["userId": userId], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        case .Room(let userIdSend, let userIdReceive):
            return .requestParameters(bodyParameters: ["userIdSend": userIdSend, "userIdReceive": userIdReceive], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        case .Message(let roomId):
            return .requestParameters(bodyParameters: ["roomId": roomId], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        case .CheckRoom(let userIdSend, let userIdReceive):
            return .requestParameters(bodyParameters: ["userIdSend": userIdSend, "userIdReceive": userIdReceive], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        case .UserInfo(let id):
            return .requestParameters(bodyParameters: ["id": id], bodyEndcoding: .jsonEncoding, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
