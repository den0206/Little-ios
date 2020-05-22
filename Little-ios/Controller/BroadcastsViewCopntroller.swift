//
//  BroadcastsViewCopntroller.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import GoogleMobileAds

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
    
    var bannerView : UIView = {
        let view = UIView()
        return view
    }()
    
    
    var nextPageToken : Int?
    /// fale indicatoe for hide footerView
    let indicator = UIActivityIndicatorView()
    
    var interstitial : GADInterstitial!
    
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
        
        interstitial = createAndLoadInterstitial()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addSubview(bannerView)
        bannerView.centerX(inView: view)
        bannerView.anchor(bottom: self.tabBarController?.tabBar.topAnchor,width: 320,height: 50)
        
        if admob_test {
             AdMobHelper.shared.setupBannerAd(adBaseView: bannerView, rootVC: self,bannerId: AdMobID.bannerViewTest.rawValue)
        } else {
            AdMobHelper.shared.setupBannerAd(adBaseView: bannerView, rootVC: self,bannerId: AdMobID.adBanner1.rawValue)
        }
       
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
        return broadcasts.count
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
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .light,scale: .medium)

        footer.nextButton.setImage(UIImage(systemName: "chevron.right", withConfiguration: symbolConfiguration), for: .normal)

        return footer
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let broadcast = broadcasts[indexPath.item]
        
//        let detailVC = DetailViewController(broadcast: broadcast)
        let detailVC = DetailViewController()
        detailVC.broadcast = broadcast
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
        
        guard let nextPageToken = self.nextPageToken else {
            collectionView.reloadData()
            return}
        
        if nextPageToken % 3 == 0 {
            
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("NO Ready")
            }
        } else {
            /// no admob
            loadNextBroadcasts(nextPage: nextPageToken)
            
        }
        
        
     
    }
    
    
    private func loadNextBroadcasts(nextPage : Int) {
        
        self.tabBarController?.showPresentLoadindView(true)
        
        var broadcasts = [Broadcast]()
        APIManager.shared.allCastsRequest(page: nextPage) { (index, error) in
            guard let index = index else {return}
            
            broadcasts = index.broadcasts
            
            self.broadcasts.append(contentsOf: broadcasts)
            self.nextPageToken = index.pagenation.pagenation.next
            
        }
    }
    
    
    
}

//MARK: - interstitial AD

extension BroadcastsViewController : GADInterstitialDelegate {

    func createAndLoadInterstitial() -> GADInterstitial {
        
        var interstitial : GADInterstitial
        
        if admob_test {
            interstitial = GADInterstitial(adUnitID: AdMobID.InterstitialTest.rawValue)
        } else {
            ///本番
            interstitial = GADInterstitial(adUnitID: AdMobID.InterstitialTest.rawValue)
            
        }
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
        
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        guard let nextPageToken = self.nextPageToken else {
            collectionView.reloadData()
            return}
        
        loadNextBroadcasts(nextPage: nextPageToken)
        
        
//        var broadcasts = [Broadcast]()
//        APIManager.shared.allCastsRequest(page: nextPageToken) { (index, error) in
//            guard let index = index else {return}
//
//            broadcasts = index.broadcasts
//
//            self.broadcasts.append(contentsOf: broadcasts)
//            self.nextPageToken = index.pagenation.pagenation.next
//
//        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
}

