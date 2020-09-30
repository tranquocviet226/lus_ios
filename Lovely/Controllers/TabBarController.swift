//
//  TabBarController.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    private func setupViewController(){
        self.modalPresentationStyle = .fullScreen
        
        guard let homeNavigation = getTabNC(viewType: HomeViewController.self, title: .Home, color: .red_start, image: "house") else { return }
        guard let storeNavigation = getTabNC(viewType: StoreViewController.self, title: .Store, color: .red_start, image: "cart") else { return }
        guard let likesNavigation = getTabNC(viewType: LikesViewController.self, title: .Likes, color: .red_start, image: "heart") else { return }
        guard let notificationNavigation = getTabNC(viewType: NotificationViewController.self, title: .Notification, color: .red_start, image: "bell") else { return }
        guard let profileNavigation = getTabNC(viewType: ProfileViewController.self, title: .Profile, color: .red_start, image: "person") else { return }
        
        viewControllers = [homeNavigation, storeNavigation, likesNavigation, notificationNavigation, profileNavigation]
    }
    
    private func getTabNC(viewType: UIViewController.Type, title: Localizable.TabBar, color: Colors, image: String) -> UINavigationController? {
        guard let vc = getVC(viewType) else { return nil }
        
        let tabBarItem = UITabBarItem(title: title.localized, image: UIImage(systemName: image)?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), selectedImage: UIImage(systemName: image + ".fill")?.withRenderingMode(.alwaysOriginal).withTintColor(color.value))
        tabBarItem.setTitleTextAttributes([.foregroundColor: color.value], for: .selected)
        
        let navigation = UINavigationController(rootViewController: vc)
        navigation.tabBarItem = tabBarItem
        
        return navigation
    }
}
