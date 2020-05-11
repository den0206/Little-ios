//
//  DetailViewController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController : UIViewController {
    
    let broadcast : Broadcast
    
    //MARK: - Parts
    

    private let imageView : UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.setDimension(width: 200, height: 200)
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 200 / 2
        return iv
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "3年3月3日"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private var guestLabel : UILabel? = {
        let label = UILabel()
        label.text = "Guest :"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        
        return label
    }()
    
    private let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    
    init(broadcast : Broadcast) {
        self.broadcast = broadcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congifureUI()
        
        setParameter()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false

    }
    
    private func setParameter() {
        
        let url = URL(string: broadcast.image)
        imageView.sd_setImage(with: url)
    }

    
    //MARK: - UI
    
    private func congifureUI() {
        view.backgroundColor = .lightGray
        
        title = "第\(broadcast.number)回"
        
        view.addSubview(imageView)
        imageView.centerX(inView: view)
        imageView.anchor(top : view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        view.addSubview(dateLabel)
        dateLabel.centerX(inView: view)
        dateLabel.anchor(top : imageView.bottomAnchor,paddingTop: 20)
        
        if let guestLabel = guestLabel, guestLabel.text != "" {
            view.addSubview(guestLabel)
            guestLabel.anchor(top : dateLabel.bottomAnchor, left: view.leftAnchor,paddingTop: 10,paddingLeft: 20)
            
            view.addSubview(separatorView)
            separatorView.anchor(top: guestLabel.bottomAnchor, left: view.leftAnchor,  right: view.rightAnchor, paddingTop: 16 ,width: view.frame.width, height: 0.5)
        } else {
            view.addSubview(separatorView)
            separatorView.anchor(top: dateLabel.bottomAnchor, left: view.leftAnchor,  right: view.rightAnchor, paddingTop: 16 ,width: view.frame.width, height: 0.5)
        }
        
    }
    
    
}

