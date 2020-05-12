//
//  WordHeaderView.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

enum WordType {
    case waka
    case kasu
}

class WordHeaderView : UICollectionReusableView {
    
    var type : WordType! {
        didSet {
            configure()
        }
    }
    
    var word : String! {
        didSet {
            setWord()
        }
    }
    //MARK: - Parts
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.setDimension(width: 45, height: 45)
        iv.layer.cornerRadius = 45 / 2
        return iv
    }()
    
    private let textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        //        tv.text = "Test"
        return tv
    }()
    
    private let bubbleContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    var bubbleLeftAnchor : NSLayoutConstraint!
    var bubbleRightAnchor : NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        switch type {
        case .waka:
            addSubview(profileImageView)
            profileImageView.anchor(top: topAnchor, left : leftAnchor ,paddingTop : 8,paddingLeft: 16)
            
            profileImageView.image = #imageLiteral(resourceName: "xSUbWKN2efIREtE1554983677_1554983709")
            addSubview(bubbleContainer)
            bubbleContainer.centerY(inView: profileImageView)
            bubbleContainer.anchor(left : profileImageView.rightAnchor, paddingLeft: 16)
            bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
            
            
            
           
            addSubview(textView)
            textView.anchor(top : bubbleContainer.topAnchor, left:  bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
        case .kasu :
            addSubview(profileImageView)
            profileImageView.anchor(top: topAnchor, right: rightAnchor ,paddingTop : 8,paddingRight: 16)
            
            profileImageView.image = #imageLiteral(resourceName: "FeYVMuZZVYt1R7c1554983733_1554983761")
            bubbleContainer.backgroundColor = UIColor(red: 255 / 255, green: 193 / 255, blue: 213 / 255, alpha: 1)
            
            addSubview(bubbleContainer)
            bubbleContainer.centerY(inView: profileImageView)
            bubbleContainer.anchor(right : profileImageView.leftAnchor, paddingRight: 16)
            bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
            
            
            
            addSubview(textView)
            textView.anchor(top : bubbleContainer.topAnchor, left:  bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
        case .none :
            break
        }
    }
    
    func setWord() {
        textView.text = word
    }

    
}
