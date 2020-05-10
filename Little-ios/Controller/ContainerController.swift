//
//  ContainerController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ContainerController : UIViewController {
    
    private let homeController = HomeController()
    private var sideMenuController = SideMenuController()
    
    private let blackView = UIView()
    
    var isExpand = false
    
    // black view X
    private lazy var xOrigin = self.view.frame.width - 80
    
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
           return .slide
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        configureHomeController()
        configureSideMenu()
        
    }
    
    private func configureHomeController() {
        addChild(homeController)
        homeController.didMove(toParent: self)
        homeController.delagate = self
        
//        let nav = UINavigationController(rootViewController: homeController)
        view.addSubview(homeController.view)
    }
    
    private func configureSideMenu() {
        addChild(sideMenuController)
//        sideMenuController.didMove(toParent: self)
        sideMenuController.delegate = self
        view.insertSubview(sideMenuController.view, at: 0)
        
        configureBlackView()
        
    }
    
    private func configureBlackView() {
        
        blackView.frame = CGRect(x: xOrigin, y: 0, width: 80, height: self.view.frame.height)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.alpha = 0
        view.addSubview(blackView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSideMenu))
        blackView.addGestureRecognizer(tap)
    }
    
    //MARK: - Action
    
    @objc func dismissSideMenu() {
        isExpand = false
        animateSideMenu(shouldExpand: isExpand)
    }
    
    //MARK: - Animate Sidemenu
    
    func animateSideMenu(shouldExpand : Bool, completion : ((Bool) -> Void)? = nil) {
        
        if shouldExpand {
            
            // show sideMenu Animation
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.homeController.view.frame.origin.x = self.xOrigin
                
                // add Black VIew
                self.blackView.alpha = 1
            }, completion: nil)
        } else {
            
            // hide black Menu
            self.blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.homeController.view.frame.origin.x = 0
            }, completion: completion)
            
        }
        
        animateStatusBar()
        
    }
    
    func animateStatusBar() {
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
               self.setNeedsStatusBarAppearanceUpdate()
           }, completion: nil)
       }
    
}



extension ContainerController : HomeControllerDelegate {
    func handleSideMenu() {
        isExpand.toggle()
        
        animateSideMenu(shouldExpand: isExpand)
        
        
        
    }
    
    
}

extension ContainerController : SideMenuControllerDelegate {
    func didSelect(type: MenuOptions) {
        switch type {
        case .broadcats:
            isExpand = false
            animateSideMenu(shouldExpand: isExpand)
            print("broadCast")
            
            
            
            //            let broadcastVC = BroadcastController()
            //            let nav = UINavigationController(rootViewController: HomeController())
            //            nav.pushViewController(broadcastVC, animated: true)
            
        default:
            return
        }
    }
    

    
    
}
