//
//  BroadcastCell.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import SDWebImage

class BroadcastCell : UICollectionViewCell {
    
    var broadcast : Broadcast? {
        didSet {
           comfigure()
        }
    }
    //MARK: - Parts
    
    private let numberLabel : UILabel = {
        let label = UILabel()
        label.text = "第３回"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        
        
        return label
    }()
    
    private let imageView : UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.setDimension(width: 180, height: 180)
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 180 / 2
//        iv.isUserInteractionEnabled = false
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
//        iv.addGestureRecognizer(tap)
        
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
    
    private let wakaImage : UIImageView = {
        
        let iv = UIImageView()
        iv.setDimension(width: 45, height: 45)
        iv.layer.cornerRadius = 45 / 2
        iv.image = #imageLiteral(resourceName: "xSUbWKN2efIREtE1554983677_1554983709")
        iv.backgroundColor = .systemBackground
        iv.contentMode = .scaleAspectFit

        return iv
    }()
    
    private lazy var wakaTextView : UITextView = {
          return configureTextView()
      }()
    
    private lazy var wakaBubble : UIView = {
        
        return configureBubbleContainerView(color: .systemBackground, tv: wakaTextView)
        
    }()
    
    
    private let kasuImage : UIImageView = {
        
        let iv = UIImageView()
        iv.setDimension(width: 45, height: 45)
        iv.layer.cornerRadius = 45 / 2
        iv.image = #imageLiteral(resourceName: "FeYVMuZZVYt1R7c1554983733_1554983761")
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    private lazy var kasuTextView : UITextView = {
        
        return configureTextView()
    }()
    
    private lazy var kasuBubble : UIView = {
        
        return configureBubbleContainerView(color: UIColor(red: 255 / 255, green: 193 / 255, blue: 213 / 255, alpha: 1), tv: kasuTextView)
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        layer.cornerRadius = 35 / 2
        
        addSubview(numberLabel)
        numberLabel.centerX(inView: self)
        numberLabel.anchor(top : self.topAnchor, paddingTop: 20)
        
    
        
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
        
        addSubview(wakaImage)
        wakaImage.anchor(top : separatorView.bottomAnchor,left: leftAnchor,paddingTop: 25,paddingLeft: 10)
        
        wakaTextView.text =  "Test"
        
        addSubview(wakaBubble)
        wakaBubble.centerY(inView: wakaImage)
        wakaBubble.anchor(left :wakaImage.rightAnchor, paddingLeft: 20)
        wakaBubble.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
        addSubview(kasuImage)
        kasuImage.anchor(top : wakaImage.bottomAnchor, right: rightAnchor,paddingTop: 50,paddingRight: 10)
        
        
        kasuTextView.text =  "Test"

        
        addSubview(kasuBubble)
        kasuBubble.centerY(inView: kasuImage)
        kasuBubble.anchor( right: kasuImage.leftAnchor,paddingRight: 20)
        kasuBubble.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - configure
    
    private func comfigure() {
        
        guard let broadcast = broadcast else {return}
        
        numberLabel.text = "第\(broadcast.number)回"
        dateLabel.text = broadcast.date
        
        guestLabel?.text = broadcast.guest
        
        wakaTextView.text = broadcast.waka
        kasuTextView.text = broadcast.kasu
        
        let url = URL(string: broadcast.image)
        imageView.sd_setImage(with: url)
        
        
    }
    
    //MARK: - Helpers UI
    
    func configureBubbleContainerView(color : UIColor, tv : UITextView) -> UIView {
        let bubbleView = UIView()
        
        bubbleView.backgroundColor = color
        bubbleView.layer.cornerRadius = 12
        
        bubbleView.addSubview(tv)
        tv.anchor(top : bubbleView.topAnchor, left:  bubbleView.leftAnchor, bottom: bubbleView.bottomAnchor, right: bubbleView.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
        
        bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true

        
        
        return bubbleView
    }
    
    func configureTextView(color : UIColor = .black) -> UITextView {
        let tv = UITextView()
        
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.textColor = color
        tv.isEditable = false
        
        return tv
    }

}
