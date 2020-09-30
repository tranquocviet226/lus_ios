//
//  NetworkManager.swift
//  Lovely
//
//  Created by MacOS on 8/28/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url your requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

enum ResponseAPI: String {
    case success = "true"
    case failure = "false"
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    static var enviroment: NetworkEnvironment {
        switch Bundle.main.bundleIdentifier {
        case "com.tranviet.Lovely":
            return .production
        default:
            return .dev
        }
    }
    private let router = Router<AppAPI>()
    
    func login(email: String, password: String, completion: @escaping (_ response: UserAPI?, _ error: String?) -> ()) {
        router.request(.LoginId(email, password)) { (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UserAPI.self, from: responseData)
                        print("LoginId - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("LoginId - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    func verifyEmail(email: String, completion: @escaping (_ response: UserAPI?, _ error: String?) -> ()) {
        router.request(.VerifyEmail(email)){ (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UserAPI.self, from: responseData)
                        print("Verify - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("Verify - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    func register(id: String, code: String, email: String, password: String, username: String, phone: Int? = 0, completion: @escaping (_ response: UserAPI?, _ error: String?) -> ()) {
        router.request(.Register(id, code, email, password, username, phone)) { (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UserAPI.self, from: responseData)
                        print("Register - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("Register - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    func getUserInfo(id: String, completion: @escaping (_ response: UserAPI?, _ error: String?) -> ()) {
        router.request(.UserInfo(id)){ (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(UserAPI.self, from: responseData)
                        print("All Room - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("All Room - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    func loadAllRoom(userId: String, completion: @escaping (_ response: [RoomInfo]?, _ error: String?) -> ()) {
        router.request(.AllRoom(userId)){ (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([RoomInfo].self, from: responseData)
                        print("All Room - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("All Room - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    func checkRoomAvailable(userIdSend: String, userIdReceive: String, completion: @escaping (_ response: RoomAvailable?, _ error: String?) -> ()) {
        router.request(.CheckRoom(userIdSend, userIdReceive)){ (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(RoomAvailable.self, from: responseData)
                        print("CheckRoom - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("CheckRoom - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    func createRoom(userIdSend: String, userIdReceive: String, completion: @escaping (_ response: RoomAPI?, _ error: String?) -> ()) {
        router.request(.Room(userIdSend, userIdReceive)) { (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(RoomAPI.self, from: responseData)
                        print("CreateRoom - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("CreateRoom - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    func loadMessageDtail(roomId: String, completion: @escaping (_ response: [Message]?, _ err: String?) -> ()) {
        router.request(.Message(roomId)){ (data, response, error) in
            if error != nil {
                if error?._code == Utils.Key.Code.NO_INTERNET {
                    completion(nil, Localizable.Error.Internet.localized)
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([Message].self, from: responseData)
                        print("LoadMessage - Response - Success")
                        completion(apiResponse, nil)
                    } catch {
                        print("LoadMessage - Response - Error")
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networlFailureError):
                    completion(nil, networlFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
