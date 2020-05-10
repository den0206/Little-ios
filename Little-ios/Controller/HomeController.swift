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
        iv.setDimension(width: 200, height: 200)
        return iv
    }()
    
    private let sideMrenuButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "text.justify"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setDimension(width: 100, height: 100)
        button.addTarget(self, action: #selector(sideMenuTapped), for: .touchUpInside)
        return button
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
        logoImageView.anchor(top : view.safeAreaLayoutGuide.topAnchor,paddingTop: 50)
        
        view.addSubview(sideMrenuButton)
        sideMrenuButton.anchor(top : view.safeAreaLayoutGuide.topAnchor, left:  view.safeAreaLayoutGuide.leftAnchor, paddingTop: 16,paddingLeft: 20, width: 30,height: 30)
        
        

        

    }
    
    @objc func sideMenuTapped() {
        
        delagate?.handleSideMenu()
    }
    
 
    
    
}
