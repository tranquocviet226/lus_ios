//
//  SocketIO.swift
//  Lovely
//
//  Created by MacOS on 9/5/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation
import SocketIO

class SocketHelper {
    
    static let shared = SocketHelper()
    var socket: SocketIOClient!
    
    let manager = SocketManager(socketURL: URL(string: Constants.httpUrl)!)
    //, config: [.log(true), .compress]
    private init() {
        socket = manager.defaultSocket
    }
    
    func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("Connect SocketIO successfully!")
            self?.socket.removeAllHandlers()
            completion(true)
        }
        socket.connect()
    }
    
    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }
    
    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false
        
    }
    
    enum Events {
        case chat
        case askId
        case mymessage
        case join
        case broadcast
        case createRoom
        
        var emitterName: String {
            switch self {
            case .chat:
                return "chat message"
            case .askId:
                return "askForUserId"
            case .mymessage:
                return "mymessage"
            case .join:
                return "join"
            case .broadcast:
                return "broadcast"
            case .createRoom:
                return "create room"
            }
        }
        
        var listnerName: String {
            switch self {
            case .chat:
                return "chat message"
            case .askId:
                return "askForUserId"
            case .mymessage:
                return "mymessage"
            case .join:
                return "join"
            case .broadcast:
                return "broadcast"
            case .createRoom:
                return "create room"
            }
        }
        
        func emit(params: [String: Any]) {
            SocketHelper.shared.socket.emit(emitterName, params)
        }
        
        func emitJoin(room: String) {
            SocketHelper.shared.socket.emit(emitterName, room)
        }
        
        func listen(completion: @escaping (Any) -> Void) {
            SocketHelper.shared.socket.on("askForUserId") { (response, emitter) in
                completion(response[0])
            }
            SocketHelper.shared.socket.emit("receiveUserId", "userA@gmail.com")
        }
        
        func listenMessage(completion: @escaping (Any) -> Void) {
            SocketHelper.shared.socket.on(listnerName) { (response, emitter) in
                completion(response)
            }
        }
        
        func off() {
            SocketHelper.shared.socket.off(listnerName)
        }
    }
}


