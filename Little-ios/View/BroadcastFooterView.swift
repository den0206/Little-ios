//
//  FooterView.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol BroadcstFooterViewDelegate {
    func handleNext()
}

class BroadcstFooterView : UICollectionReusableView {
    //MARK: - parts
    
    var delegate : BroadcstFooterViewDelegate?
    
    let nextButton : UIButton = {
        let button = UIButton()
//        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .light,scale: .medium)
//        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: symbolConfiguration), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(nextButton)
        nextButton.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleNext() {
        delegate?.handleNext()
    }
}
