//
//  WordHeaderView.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit


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
    
    var imageLeftAnchor : NSLayoutConstraint!
    var imageRightAnchor : NSLayoutConstraint!

    var bubbleLeftAnchor : NSLayoutConstraint!
    var bubbleRightAnchor : NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,paddingTop : 8)
        
        imageLeftAnchor = profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        imageLeftAnchor.isActive = false
        imageRightAnchor = profileImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        imageRightAnchor.isActive = false
        
        
        addSubview(bubbleContainer)
        bubbleContainer.centerY(inView: profileImageView)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: profileImageView.leftAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        

        addSubview(textView)
        textView.anchor(top : bubbleContainer.topAnchor, left:  bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        switch type {
        case .waka:
            imageLeftAnchor.isActive = true
            bubbleLeftAnchor.isActive = true
        case .kasu :
            imageRightAnchor.isActive = true
            bubbleRightAnchor.isActive = true
            
        case .none :
            break
        }
    }
    
    func setWord() {
        textView.text = word
    }

    
}
