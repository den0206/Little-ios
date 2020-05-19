//
//  WordsViewController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/19.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "wordsCell"
private let headerIdentifer = "HeaderView"



class WordsViewController : UIViewController {
    
    var wordType : WordType = .waka
    
    //MARK: - Parts
    
    let collectionView : UICollectionView = {

        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .black
        
        return cv
    }()
    
    private lazy var segmentController : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["若林", "春日"])
        sc.selectedSegmentIndex = 0
        sc.frame = CGRect(x: 10, y: 100, width: (self.view.frame.width - 20), height: 50)
        sc.layer.cornerRadius = 5.0
        
        sc.backgroundColor = UIColor.systemPink
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - SegmentController
    @objc func indexChanged(sender : UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            wordType = .waka
            segmentController.backgroundColor = .systemPink
        case 1 :
            wordType = .kasu
            segmentController.backgroundColor = .blue
            collectionView.reloadData()

        default:
            return
        }
    }
    
    //MARK: - UI
    
    private func configureCV() {
        
        view.addSubview(segmentController)
        
        let segY = segmentController.frame.origin.y + segmentController.frame.height + 50
        collectionView.frame = CGRect(x: 0, y: segY, width: view.frame.width, height: view.frame.height)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(WordsCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.register(ImageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer)
    }
    
    
}

extension WordsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! WordsCell
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
    /// header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer, for: indexPath) as! ImageHeaderView
        
        switch wordType {
        case .waka :
            header.type = .waka
            return header
        case .kasu :
            header.type = .kasu
            return header
      
        }
    }
    
    
}

extension WordsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 10.0, left: 0, bottom: 50.0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
          let size = CGSize(width: 250, height: 250)
          let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

          return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
      }
}
