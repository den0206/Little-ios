//
//  DetailHeaderView.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import SDWebImage


protocol DetailHeaderViewDelegate {
    func backAction()
}

class DetailHeaderView : UIView {
    
    var broadcast : Broadcast? {
        didSet {
            configure()
        }
    }
    
    var delegate : DetailHeaderViewDelegate?
    //MARK: - Parts
    
    private let numberLabel : UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.font = UIFont(name: "851CHIKARA-DZUYOKU-KANA-A", size: 16.0)
        
        return label
    }()
    
    
    private let imageView : UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.setDimension(width: 50, height: 50)
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 50 / 2
        return iv
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont(name: "851CHIKARA-DZUYOKU-KANA-A", size: 16.0)
        label.textColor = .black
        return label
    }()
    
    private var guestLabel : UILabel? = {
        let label = UILabel()
        label.font = UIFont(name: "851CHIKARA-DZUYOKU-KANA-A", size: 16.0)
        label.textColor = .black
        return label
    }()
    
    private let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let backButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setDimension(width: 100, height: 100)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        
        
        
        addSubview(backButton)
        backButton.anchor(top : safeAreaLayoutGuide.topAnchor, left:  safeAreaLayoutGuide.leftAnchor, paddingTop: 16,paddingLeft: 20, width: 30,height: 30)
        
        addSubview(numberLabel)
        numberLabel.centerX(inView: self)
        numberLabel.anchor(top :self.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        addSubview(imageView)
        imageView.anchor(top : backButton.bottomAnchor,left: self.leftAnchor, paddingTop: 8, paddingLeft: 16)
        
        addSubview(dateLabel)
        dateLabel.centerY(inView: imageView)
        dateLabel.centerX(inView: self)
        
        if let guestLabel = guestLabel, guestLabel.text != "" {
            addSubview(guestLabel)
            guestLabel.anchor(top : imageView.bottomAnchor, left: leftAnchor,paddingTop: 15,paddingLeft: 20)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Actions
    
    private func configure() {
        guard let broadcast = broadcast else {return}
        
        let url = URL(string: broadcast.image)
        imageView.sd_setImage(with: url)
        
        numberLabel.text = "\(broadcast.number)回"
        
        dateLabel.text = broadcast.date
        
        guestLabel?.text = broadcast.guest
    }
    
    @objc func backAction() {
        delegate?.backAction()
    }
    
}
