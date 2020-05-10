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
    
    var broadcasts = [Snippet]() {
        didSet {
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
                self.navigationController?.showPresentLoadindView(false)

            }
        }
    }
    
    var nextPageToken : Int?
    
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
        fetchAllCasts()
     
    }
    
    private func configureCV(){
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        title = "全放送回"
        collectionView.backgroundColor = .black
        
//
        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 50, right: 24)
        collectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 25, left: 0, bottom: 50, right: 24)
        
        collectionView.register(BroadcaastCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.register(BroadcstFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifer)
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    //MARK: - API
    
    private func fetchAllCasts() {
        
        self.navigationController?.showPresentLoadindView(true)

        APIManager.shared.allCastsRequest { (index, error) in
            guard let index = index else {return}
            /// self.nextPageToken = index.pagenation.pagenation.next
            self.broadcasts = index.broadcats
            self.nextPageToken = index.pagenation.pagenation.next
           
        }
    }
    
}

extension BroadcastsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return broadcasts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! BroadcaastCell
        
        cell.snippet = broadcasts[indexPath.item]
        return cell
    }
    
    /// header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifer, for: indexPath) as! BroadcstFooterView
        footer.delegate = self
        return footer
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
        
        return 37
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        
        return CGSize(width: 100, height: 0)
    }
    

}

//MARK: - Show More

extension BroadcastsViewController : BroadcstFooterViewDelegate {
    func handleNext() {
        
        guard let nextPageToken = self.nextPageToken else {return}
        
        self.navigationController?.showPresentLoadindView(true)

        var snippets = [Snippet]()
        APIManager.shared.allCastsRequest(page: nextPageToken) { (index, error) in
            guard let index = index else {return}
            
            snippets = index.broadcats
            
            self.broadcasts.append(contentsOf: snippets)
            self.nextPageToken = index.pagenation.pagenation.next
            
        }
    }
    
    
}
