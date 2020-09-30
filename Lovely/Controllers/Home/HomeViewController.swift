//
//  HomeViewController.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var badgeBackground: UIView!
    @IBOutlet weak var badgeNumber: UILabel!
    
    var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    var images: [Story] = []
    var roomInfo: [RoomInfo] = []
    var num: Int = 0
    
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        getStoryData()
        loadAllRoom()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveMess), name: Notification.Name.newMessage, object: nil)
        
        SocketHelper.Events.mymessage.listenMessage { (result) in
            NotificationCenter.default.post(name: Notification.Name.newMessage, object: nil)
            self.num = self.num + 1
            self.badgeNumber.text = String(describing: self.num)
            if self.num == 0 {
                self.badgeBackground.isHidden = true
            } else {
                self.badgeBackground.isHidden = false
            }
        }
        SocketHelper.Events.broadcast.listenMessage { (result) in
            NotificationCenter.default.post(name: Notification.Name.roomInfo, object: nil)
            self.loadAllRoom()
        }
    }
    
    @objc func receiveMess(){
        self.loadNoti()
    }
    
    private func setupUI(){
        setHideNavigation()
        setupBackground()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(navigationMessage))
        badgeBackground.addGestureRecognizer(gesture)
        if num == 0 {
            badgeBackground.isHidden = true
        }
        badgeBackground.layer.cornerRadius = badgeBackground.frame.width / 2
        tableView.addSubview(refreshControl)
    }
    
    @objc func navigationMessage(){
        num = 0
        badgeBackground.isHidden = true
        guard let messageVC = getVC(MessageViewController.self) else {
            return
        }
        navigationController?.pushViewController(messageVC, animated: true)
    }
    
    @IBAction func messageHandle(_ sender: UIButton) {
        navigationMessage()
    }
    
    @objc private func loadAllRoom(){
        let userId = _UserDefault.get(key: .userId)
        networkManager.loadAllRoom(userId: userId as! String){ (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert_error(error)
                }
                if let response = response {
                    self.roomInfo = response
                    for roomId in 0 ..< response.count {
                        SocketHelper.Events.join.emitJoin(room: response[roomId].roomId)
                    }
                }
                let _ = self.removeLoadingView()
            }
        }
    }
    
    private func loadNoti(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]){ (granted, err) in
            //            print(granted)
        }
        
        // Step 2
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "A new message for you <3"
        
        // Step 2
        let date = Date().addingTimeInterval(1)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //Step 4
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Step 5
        center.add(request){(error) in
            // Check error
        }
    }
    
    private func getStoryData(){
        images.append(Story(idol_id: "idUser1", user_name: "Your Story", image_path: "https://png.pngtree.com/element_our/20190601/ourlarge/pngtree-plus-icon-image_1338383.jpg", title: "Hom nay toi buon"))
        images.append(Story(idol_id: "5f64a56b0eb71c2fb120069a", user_name: "Tran Quoc Viet", image_path: "https://thuthuatnhanh.com/wp-content/uploads/2019/12/anh-gai-xinh-de-thuong-cap-3-580x580.jpg", title: "Heloo ngay moi"))
        images.append(Story(idol_id: "5f6572eb3736d80848fe19df", user_name: "ADMIN", image_path: "https://cdn.24h.com.vn/upload/1-2019/images/2019-02-19/1550571366-393-anh-2-1550570116-width650height813.jpg", title: "Ngay gi dau khong"))
        images.append(Story(idol_id: "idUser2", user_name: "Thanh", image_path: "https://media.ex-cdn.com/EXP/media.giadinhvietnam.com/files/khanhangdvn/2018/11/06/co-giao-tran-tran-1511.jpg", title: "Thanh buoon"))
        images.append(Story(idol_id: "idUser3", user_name: "My", image_path: "https://1.bp.blogspot.com/-6cx2g48sid8/XfXnMYbeZ8I/AAAAAAAAUSM/55zY2IBYz3Al2QuxLK8Q2RlcQuVt4caMwCLcBGAsYHQ/s1600/Hinh-Anh-Hot-Girl-Facebook-Wap102-Com%2B%25281%2529.jpg", title: "Khoc 1 dong song"))
        images.append(Story(idol_id: "idUser4", user_name: "Yen", image_path: "https://media.ex-cdn.com/EXP/media.giadinhvietnam.com/files/khanhangdvn/2018/11/06/co-giao-tran-tran-1511.jpg", title: "Sao nao babe"))
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableCell", for: indexPath) as? RecommendTableCell else {
                return UITableViewCell()
            }
            let images: [String] = ["https://previews.123rf.com/images/svetabelaya/svetabelaya1812/svetabelaya181200008/127241092-dating-service-web-banner-with-young-couple-broken-heart-words-repare-your-heart-and-call-to-action-.jpg", "https://previews.123rf.com/images/svetabelaya/svetabelaya1812/svetabelaya181200010/112912917-dating-service-web-banner-with-heart-and-key-words-start-with-a-date-and-call-to-action-button-roman.jpg", "https://previews.123rf.com/images/maridav/maridav1901/maridav190100070/114551295-couple-falling-in-love-dating-laughing-having-fun-on-summer-outdoor-date-in-sunset-panorama-banner-i.jpg", "https://originatesoft.com/products/dating-script/assets/images/banner_1.jpg?10"]
            cell.recommend = images
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableCell", for: indexPath) as? StoryTableCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            cell.getStory(story: images)
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotIdolTableCell", for: indexPath) as? HotIdolTableCell else {
                return UITableViewCell()
            }
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListLabelTableCell", for: indexPath) as? ListLabelTableCell else {
                return UITableViewCell()
            }
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell", for: indexPath) as? ListTableCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension HomeViewController: CollectionInsideTableDelegate {
    func cellTaped(data: Story?) {
        guard let idolDetailVC = getVC(IdolDetailViewController.self) else {
            return
        }
        idolDetailVC.idolName = data?.idol_id
        idolDetailVC.idolImage = data?.image_path
        navigationController?.pushViewController(idolDetailVC, animated: true)
    }
}
