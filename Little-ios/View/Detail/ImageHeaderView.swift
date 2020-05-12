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

class ImageHeaderView : UICollectionReusableView {
    
    var type : WordType! {
        didSet {
            configure()
        }
    }
    
 
    //MARK: - Parts
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.setDimension(width: 50, height: 50)
        iv.layer.cornerRadius = 50 / 2
        return iv
    }()
    

 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.center(inView: self)
    
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        switch type {
        case .waka:
            profileImageView.image = #imageLiteral(resourceName: "xSUbWKN2efIREtE1554983677_1554983709")
        case .kasu :
            profileImageView.image = #imageLiteral(resourceName: "FeYVMuZZVYt1R7c1554983733_1554983761")
            
        case .none :
            break
        }
    }


    
}

