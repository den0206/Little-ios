//
//  BroadcastsViewCopntroller.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "BroadcastCell"

class BroadcastsViewController : UICollectionViewController {
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
   
    var cellOffset: CGFloat!
    var navHeight: CGFloat!
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCV()
     
    }
    
    private func configureCV(){
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        title = "全放送回"
        collectionView.backgroundColor = .black
        
//
//        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 50, right: 0)
//        collectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 25, left: 0, bottom: 50, right: 0)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
}

extension BroadcastsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath)
        
        cell.backgroundColor = .yellow
        return cell
    }
    
    
}


extension BroadcastsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = viewWidth-75
        let cellHeight = viewHeight-300
        
        cellOffset = viewWidth-cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: -navHeight,left: cellOffset/2,bottom: 0,right: cellOffset/2)
       }
    
}
