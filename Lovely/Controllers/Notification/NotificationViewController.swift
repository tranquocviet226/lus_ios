//
//  NotificationViewController.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Step 1
        
    }
    
    private func setupUI(){
        setHideNavigation()
        setupBackground()
    }
    
    @IBAction func changeHandle(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("Profile"), object: nil)
        
    }
    @IBAction func removeHandle(_ sender: UIButton) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]){ (granted, err) in
            print(granted)
        }
        
        // Step 2
        let content = UNMutableNotificationContent()
        content.title = "Hey Sir"
        content.body = "Wake up wake up"
        
        // Step 2
        let date = Date().addingTimeInterval(5)
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
    
}
