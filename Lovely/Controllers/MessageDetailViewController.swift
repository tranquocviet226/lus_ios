//
//  MessageDetailViewController.swift
//  Lovely
//
//  Created by MacOS on 9/18/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class MessageDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    var messages: [Message] = []
    var userIdReceive: String? = ""
    var roomId: String? = ""
    var image_path_receive: String?
    var image_path: String?
    
    let userId = _UserDefault.get(key: .userId)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configKeyboard()
        checkRoom()
        getUserInfo()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        
        SocketHelper.Events.mymessage.listenMessage { (result) in
            let mess = Message(roomId: "", userIdSend: (result as! [String])[0], userIdReceive: "", content: (result as! [String])[1])
            self.messages.insert(mess, at: 0)
            self.tableView.reloadData()
        }
    }
    private func setupUI(){
        setupBackground()
        setHideNavigation()
        setupNavigation(isBack: true)
        
        KeyboardAvoiding.avoidingView = self.view
        tableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi));
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: tableView.bounds.size.width - 8.0)
    }
    @objc func dissmissHandle(){
        view.endEditing(true)
    }
    
    private func configKeyboard(){
        let dissmissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissHandle))
        view.addGestureRecognizer(dissmissKeyboard)
    }
    
    private func getUserInfo(){
        networkManager.getUserInfo(id: userIdReceive ?? ""){ (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    self.image_path_receive = response.data?.user?.image
                }
            }
        }
        networkManager.getUserInfo(id: userId as! String){ (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    self.image_path = response.data?.user?.image
                }
            }
        }
    }
    
    private func checkRoom(){
        addLoadingView()
        networkManager.checkRoomAvailable(userIdSend: userId as! String, userIdReceive: userIdReceive ?? ""){ (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    if response.status == true {
                        self.createRoom()
                    } else {
                        self.roomId = response.roomId
                        SocketHelper.Events.join.emitJoin(room: self.roomId ?? "")
                        self.loadMessagesData(roomId: response.roomId)
                    }
                }
                let _ = self.removeLoadingView()
            }
        }
    }
    
    private func createRoom(){
        addLoadingView()
        networkManager.createRoom(userIdSend: userId as! String, userIdReceive: userIdReceive ?? ""){(response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    NotificationCenter.default.post(name: Notification.Name.roomInfo, object: nil)
                    self.roomId = response.data?.roomId
                    SocketHelper.Events.join.emitJoin(room: (response.data?.roomId)!)
                }
                let _ = self.removeLoadingView()
            }
        }
    }
    private func loadMessagesData(roomId: String){
        addLoadingView()
        networkManager.loadMessageDtail(roomId: roomId ){ (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    for i in stride(from: response.count - 1, to: -1, by: -1){
                        let mess = Message(roomId: "", userIdSend: response[i].userIdSend, userIdReceive: "", content: response[i].content)
                        self.messages.append(mess)
                    }
                    self.tableView.reloadData()
                }
                let _ = self.removeLoadingView()
            }
        }
    }
    @IBAction func sendMessagehandle(_ sender: UIButton) {
        let text = messageTextField.text ?? ""
        if text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
            SocketHelper.Events.chat.emit(params: ["roomId": roomId!, "userIdSend": userId ?? "", "userIdReceive": userIdReceive!, "content": text])
            SocketHelper.Events.createRoom.emitJoin(room: "Create Room")
            messageTextField.text = ""
            dissmissHandle()
        } else {
            messageTextField.text = ""
            dissmissHandle()
        }
    }
}

extension MessageDetailViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userId as! String != messages[indexPath.row].userIdSend {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageDetailTableCell", for: indexPath) as? MessageDetailTableCell else {return UITableViewCell()}
            
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
            cell.avatarImage.sd_setImage(with: URL(string: image_path_receive ?? "girl"))
            cell.messageContent?.text = messages[indexPath.row].content
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageSendDetailTableCell", for: indexPath) as? MessageSendDetailTableCell else {return UITableViewCell()}
            
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
            cell.avatarImage.sd_setImage(with: URL(string: image_path ?? "girl"))
            cell.messageContent?.text = messages[indexPath.row].content
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return false
    }
}
