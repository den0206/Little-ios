//
//  WordsViewController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/19.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import GoogleMobileAds

private let reuseIdentifer = "wordsCell"
private let headerIdentifer = "HeaderView"
private let footerIdentifer = "footerView"




class WordsViewController : UIViewController {
    
    var wordType : WordType = .waka
    
    var wawos = [Wawo]() {
        didSet {
            print(wawos.count)
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
                self.tabBarController?.showPresentLoadindView(false)
                self.dummyIndicator.stopAnimating()

                
            }
        }
    }
    
    var wakaPage : Int?
    
    var kawos = [Kawo]() {
        didSet {
            print(kawos.count)
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
                self.tabBarController?.showPresentLoadindView(false)
                self.dummyIndicator.stopAnimating()


                
            }
        }
    }
    
    var kasuPage : Int?
    
    var isFirst = true
    
    var interstitial : GADInterstitial!

    //MARK: - Parts
    
    let collectionView : UICollectionView = {

        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .black
        
        return cv
    }()
    
    private lazy var segmentController : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["若林", "春日"])
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5.0
        
        sc.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        // 選択時の背景色
        if #available(iOS 13.0, *) {
            sc.selectedSegmentTintColor = UIColor.black
        }
        else {
            sc.tintColor = UIColor.black
        }
        // 文字色
        sc.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        // 枠線
        sc.layer.borderWidth = 2

        sc.layer.borderColor = UIColor.white.cgColor
        sc.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        return sc
        
    }()
    
    var bannerView : UIView = {
        let view = UIView()
        return view
    }()
    
    var dummyIndicator = UIActivityIndicatorView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureCV()
        
        fetchWaka()
        
        interstitial = createAndLoadInterstitial()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        if admob_test {
            AdMobHelper.shared.setupBannerAd(adBaseView: bannerView, rootVC: self,bannerId: AdMobID.bannerViewTest.rawValue)
        } else {
            print("本番")

            AdMobHelper.shared.setupBannerAd(adBaseView: bannerView, rootVC: self,bannerId: AdMobID.adBanner2.rawValue)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - SegmentController
    @objc func indexChanged(sender : UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            wordType = .waka
            segmentController.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            collectionView.reloadData()
        //            fetchWaka()
        case 1 :
            wordType = .kasu
            segmentController.backgroundColor = .systemPink
            
            if isFirst {
                fetchKasu()
                isFirst = false
                
            } else {
                collectionView.reloadData()
            }
            
        default:
            return
        }
    }
    
    //MARK: - UI
    
    private func configureCV() {
        
        view.addSubview(bannerView)
        bannerView.centerX(inView: view)
        bannerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 15, width: 320,height: 50)
        
        print(bannerView.frame.origin.y)
        view.addSubview(segmentController)
        
        segmentController.frame = CGRect(x: 10, y: 100, width: (self.view.frame.width - 20), height: 50)
        segmentController.anchor(top : bannerView.bottomAnchor,left : view.leftAnchor,right: view.rightAnchor, paddingTop: 15,paddingLeft: 10,paddingRight: 10, width: (self.view.frame.width - 20), height: 50)

        
        let segY = segmentController.frame.origin.y + segmentController.frame.height + 50
        collectionView.frame = CGRect(x: 0, y: segY, width: view.frame.width, height: view.frame.height)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(WordsCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.register(ImageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer)
        collectionView.register(BroadcstFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifer)
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 200, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 200, right: 0)
    }
    
    //MARK: - API
    
    private func fetchWaka(number : Int = 1) {
        
        self.tabBarController?.showPresentLoadindView(true)
        self.dummyIndicator.startAnimating()
        APIManager.shared.getWords(number: number, wordType: .waka) { (word, error) in
            
            if error != nil {
                self.tabBarController?.showPresentLoadindView(false)
                self.dummyIndicator.stopAnimating()

                self.showErrorAlert(message: error!.localizedDescription)
            }
            
            guard let wawos = word?.wawos else {return}
            self.wawos.append(contentsOf: wawos)
            self.wakaPage = word?.pagenation.pagenation.next
        }
        
       
    }
    
    private func fetchKasu(number : Int = 1) {
        
        self.tabBarController?.showPresentLoadindView(true)
        self.dummyIndicator.startAnimating()

        APIManager.shared.getWords(number: number, wordType: .kasu) { (word, error) in
            
            if error != nil {
                self.tabBarController?.showPresentLoadindView(false)
                self.dummyIndicator.stopAnimating()
                self.showErrorAlert(message: error!.localizedDescription)
            }
            
            guard let kawos = word?.kawos else {return}
            self.kawos.append(contentsOf: kawos)
            self.kasuPage = word?.pagenation.pagenation.next
        }
    }
    
    
    
}

extension WordsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch wordType {
        case .waka:
            return wawos.count
        case .kasu :
            return kawos.count
   
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! WordsCell
        
        cell.backgroundColor = .clear
        
        var word : String
        
        switch wordType {
        case .waka:
            word = wawos[indexPath.item].body
            cell.bubbleContainer.backgroundColor = .systemBackground

        case .kasu :
            word = kawos[indexPath.item].body
            cell.bubbleContainer.backgroundColor = UIColor(red: 255 / 255, green: 193 / 255, blue: 213 / 255, alpha: 1)
            
        }
        
        cell.word = word
        cell.textView.font = UIFont(name: "851CHIKARA-DZUYOKU-KANA-A", size: 20.0)
        
        return cell
    }
    
    /// header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == "UICollectionElementKindSectionHeader") {
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer, for: indexPath) as! ImageHeaderView
              
              switch wordType {
              case .waka :
                  header.type = .waka
                  return header
              case .kasu :
                  header.type = .kasu
                  return header
            
              }

        } else {
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifer, for: indexPath) as! BroadcstFooterView
            footer.delegate = self
            footer.nextButton.setTitle("もっと読む", for: .normal)
            footer.nextButton.titleLabel?.font =  UIFont(name: "851CHIKARA-DZUYOKU-KANA-A", size: 18.0)
            return footer
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var broadcastId : Int
        
        switch wordType {
        case .waka:
            broadcastId = wawos[indexPath.item].broadcastID
        case .kasu :
            broadcastId = kawos[indexPath.item].broadcastID
        }
        
        let detailVC = DetailViewController()
        detailVC.broadcatId = broadcastId
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
}

extension WordsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {


        return UIEdgeInsets(top: 10.0, left: 0, bottom: 20, right: 0)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if self.dummyIndicator.isAnimating {
            return .zero
        }
        
        return CGSize(width: view.frame.width, height: 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var word : String
        
        switch wordType {
        case .waka:
            word = wawos[indexPath.item].body
        case .kasu :
            word = kawos[indexPath.item].body
            
        }
        
        var height: CGFloat = 80 //Arbitrary number
        
        height = estimatedFrameForText(text: word).height + 30
        
        
        return CGSize(width: view.frame.width, height: height)
        
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 250, height: 250)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
      }
}

extension WordsViewController : BroadcstFooterViewDelegate {
    
    func handleNext() {
       
        
        switch wordType {
        case .waka:
            guard let wakaPage = wakaPage else {return}
            
            if wakaPage % 3 == 0 {
                if interstitial.isReady {
                    interstitial.present(fromRootViewController: self)
                } else {
                    print("NO Ready")
                }
            } else {
                fetchWaka(number: wakaPage)
            }
            
        case .kasu :
            guard let kasuPage = kasuPage else {return}
            
            if kasuPage % 3 == 0 {
                if interstitial.isReady {
                    interstitial.present(fromRootViewController: self)
                } else {
                    print("NO Ready")
                }
            } else {
                fetchKasu(number: kasuPage)
                
            }
        }
    }
    
    
}

//MARK: - interstitial AD

extension WordsViewController : GADInterstitialDelegate {
    
    func createAndLoadInterstitial() -> GADInterstitial {
        
        var interstitial : GADInterstitial
        
        if admob_test {
            interstitial = GADInterstitial(adUnitID: AdMobID.InterstitialTest.rawValue)
        } else {
            ///本番 (inter2)
            print("本番")
            interstitial = GADInterstitial(adUnitID: AdMobID.inter2.rawValue)
        }
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
        
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        
        switch wordType  {
        case .waka:
            guard let wakaPage = wakaPage else {return}
            fetchWaka(number: wakaPage)
        case .kasu :
            guard let kasuPage = kasuPage else {return}
            
            fetchKasu(number: kasuPage)
        }
        
    }
    
    /// ra make
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
}
