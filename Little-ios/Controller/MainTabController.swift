//
//  MainTabController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabController()
    }
    
    func configureTabController() {
        
        let homeVC = HomeController()
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.title = "Home"

        
        let broadcastsVC = BroadcastsViewController()
        let nav1 = templetaNavigationController(image: UIImage(systemName: "tv.music.note.fill"), title: "放送回", rootController: broadcastsVC)
        
        
        
        viewControllers = [homeVC, nav1]
        
        self.tabBar.barTintColor = .black
        
        UITabBar.appearance().tintColor = .red
        tabBar.unselectedItemTintColor = .white
    }
    
    //MARK: -Config NAV
    
    private func templetaNavigationController(image: UIImage?,title : String, rootController : UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootController)
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        //        appearence.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        appearence.backgroundColor = UIColor.black
        
        /// navigationController border Color
        appearence.shadowColor = .clear
        
        nav.navigationBar.standardAppearance = appearence
        nav.navigationBar.compactAppearance = appearence
        nav.navigationBar.scrollEdgeAppearance = appearence
        
        nav.navigationBar.tintColor = .white
        nav.navigationBar.layer.borderColor = UIColor.white.cgColor
        
        
        //        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        
        return nav
    }
    
    
}

/// when tap tab color

extension MainTabController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items!)[0]{
            tabBar.tintColor = .red
        }
        else if item == (self.tabBar.items!)[1]{
           tabBar.tintColor = .green
        }
    }
}

