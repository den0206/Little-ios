//
//  WordsCell.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/13.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class WordsCell : UICollectionViewCell {
    
    var word : String? {
        didSet {
            setWord()
            
        }
    }
    

    
    //MARK: - Pats
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        tv.font = UIFont(name: "851CHIKARA-DZUYOKU-KANA-A", size: 16.0)
        tv.isEditable = false
        tv.text = "Test"
        tv.isUserInteractionEnabled = false

        return tv
    }()
    
    let bubbleContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(bubbleContainer)
        bubbleContainer.center(inView: self)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        
        
        
        addSubview(textView)
        textView.anchor(top : bubbleContainer.topAnchor, left:  bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setWord() {
        guard let word = word else {return}
        
        textView.text = word
    }
    


}
