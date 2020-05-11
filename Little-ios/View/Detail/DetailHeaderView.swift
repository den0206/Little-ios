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
          label.text = "第３回"
          label.font = UIFont.boldSystemFont(ofSize: 16)
          label.textColor = .white
          
          
          return label
      }()
      

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
        imageView.centerX(inView: self)
        imageView.anchor(top : numberLabel.bottomAnchor, paddingTop: 20)
        
        addSubview(dateLabel)
        dateLabel.centerX(inView: self)
        dateLabel.anchor(top : imageView.bottomAnchor,paddingTop: 20)
        
        if let guestLabel = guestLabel, guestLabel.text != "" {
            addSubview(guestLabel)
            guestLabel.anchor(top : dateLabel.bottomAnchor, left: leftAnchor,paddingTop: 10,paddingLeft: 20)
            
            addSubview(separatorView)
            separatorView.anchor(top: guestLabel.bottomAnchor, left: leftAnchor,  right: rightAnchor, paddingTop: 16 ,width: frame.width, height: 0.5)
        } else {
            addSubview(separatorView)
            separatorView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor,  right: rightAnchor, paddingTop: 16 ,width: frame.width, height: 0.5)
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
    }
    
    @objc func backAction() {
        delegate?.backAction()
    }
    
}
