//
//  BroadcastsViewCopntroller.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "BroadcastCell"
private let footerIdentifer = "footerView"

class BroadcastsViewController : UICollectionViewController {
    
    var broadcasts = [Broadcast]() {
        didSet {
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.indicator.stopAnimating()
                self.tabBarController?.showPresentLoadindView(false)

            }
        }
    }
    
    var nextPageToken : Int?
    /// fale indicatoe for hide footerView
    let indicator = UIActivityIndicatorView()
    
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
//        fetchAllCasts()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    private func configureCV(){
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        title = "放送回"
        collectionView.backgroundColor = .black
        
//
        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 24)
        collectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 24)
        
        collectionView.register(BroadcastCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.register(BroadcstFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifer)
        
        
    }
    
    //MARK: - API
    
    private func fetchAllCasts() {
        
        self.tabBarController?.showPresentLoadindView(true)
        /// faks indicator
        indicator.startAnimating()

        APIManager.shared.allCastsRequest { (index, error) in
            guard let index = index else {return}
            /// self.nextPageToken = index.pagenation.pagenation.next
            self.broadcasts = index.broadcasts
            self.nextPageToken = index.pagenation.pagenation.next
           
        }
    }
    
}

extension BroadcastsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
//        return broadcasts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! BroadcastCell
        
        cell.broadcast = broadcasts[indexPath.item]
        return cell
    }
    
    /// header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifer, for: indexPath) as! BroadcstFooterView
        footer.delegate = self
        return footer
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let broadcast = broadcasts[indexPath.item]
        
        let detailVC = DetailViewController(broadcast: broadcast)
        navigationController?.pushViewController(detailVC, animated: false)
        
    }
    
    
}


extension BroadcastsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let cellWidth = viewWidth-75
        let cellHeight = viewHeight-200
        
        cellOffset = viewWidth-cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 37
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if indicator.isAnimating {
            return CGSize.zero
        }
        return CGSize(width: 100, height: 0)
    }
    

}

//MARK: - Show More

extension BroadcastsViewController : BroadcstFooterViewDelegate {
    func handleNext() {
        
        guard let nextPageToken = self.nextPageToken else {return}
        
        self.tabBarController?.showPresentLoadindView(true)

        var broadcasts = [Broadcast]()
        APIManager.shared.allCastsRequest(page: nextPageToken) { (index, error) in
            guard let index = index else {return}
            
            broadcasts = index.broadcasts
            
            self.broadcasts.append(contentsOf: broadcasts)
            self.nextPageToken = index.pagenation.pagenation.next
            
        }
    }
    
    
}

