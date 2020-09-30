//
//  MessageViewController.swift
//  Lovely
//
//  Created by MacOS on 9/10/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
import UserNotifications

class MessageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    var friends: [RoomInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadAllRoom()
        
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(loadAllRoom), name: Notification.Name.roomInfo, object: nil)
    }
    
    private func setupUI(){
        setupBackground()
        setHideNavigation()
        setupNavigation(isBack: true)
    }
    
    @objc private func loadAllRoom(){
        let userId = _UserDefault.get(key: .userId)
        networkManager.loadAllRoom(userId: userId as! String){ (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    self.friends = response
                    self.tableView.reloadData()
                }
                let _ = self.removeLoadingView()
            }
        }
    }
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableCell", for: indexPath) as? MessageTableCell else {return UITableViewCell()}
        
        cell.room = friends[indexPath.row]
        cell.nameLabel?.text = friends[indexPath.row].nameReceive
        cell.contentLabel.text = "Hello Viet"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let messageDetailVC = getVC(MessageDetailViewController.self) else {
            return
        }
        messageDetailVC.userIdReceive = friends[indexPath.row].userIdReceive
        
        navigationController?.pushViewController(messageDetailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

