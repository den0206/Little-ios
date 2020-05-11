//
//  HomeController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol HomeControllerDelegate : class {
    func handleSideMenu()
}

class HomeController : UIViewController {
    
    var delagate : HomeControllerDelegate?
    
    //MARK: - parts
    
    //    private lazy var centerImageView : UIImageView = {
    //        let iv = UIImageView()
    //        iv.image = #imageLiteral(resourceName: "Audly")
    //        iv.contentMode = .scaleAspectFit
    //        iv.setDimension(width: self.view.frame.width, height: 500)
    //        return iv
    //    }()
    
    private let logoImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "little")
        iv.setDimension(width: 250, height: 250)
        return iv
    }()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.anchor(top : view.safeAreaLayoutGuide.topAnchor,paddingTop: 150)
        


    }
    
    @objc func sideMenuTapped() {
        
        delagate?.handleSideMenu()
    }
    
 
    
    
}

