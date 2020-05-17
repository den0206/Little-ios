//
//  DetailViewController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "wordsCell"
private let headerIdentifer = "HeaderView"

class DetailViewController : UIViewController {
    
    let broadcast : Broadcast
    
    var wawos = [String]()
    var kawos = [String]()

    
    //MARK: - Parts
    
    lazy var headerView : DetailHeaderView = {
        let view = DetailHeaderView()
        view.delegate = self
        view.broadcast = self.broadcast
        return view
    }()
    
    private let separateView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .lightGray
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    init(broadcast : Broadcast) {
        self.broadcast = broadcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congifureUI()
        configureCV()
        
        fetchWords()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false

    }
    


    //MARK: - UI
    
    private func congifureUI() {
        view.backgroundColor = .lightGray
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        view.addSubview(headerView)
        
        headerView.addSubview(separateView)
        separateView.anchor(left : headerView.leftAnchor,bottom: headerView.bottomAnchor,right: headerView.rightAnchor,height: 2)
        
        collectionView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height)

        view.addSubview(collectionView)
        
        
    }
    
    private func configureCV() {
        
        collectionView.register(WordsCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.register(ImageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer)
        
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = true
        
        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 155, right: 0)
        collectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 25, left: 0, bottom: 155, right: 0)
    
    }
    
    //MARK: - API
    
    private func fetchWords() {
        APIManager.shared.oneCastRequest(number: broadcast.number) { (words, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                self.showErrorAlert(message: error!.localizedDescription)
            }
            
            guard let words = words else {return}
            //
            self.wawos = words.wawos
            self.kawos = words.kawos
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
//                self.collectionView.collectionViewLayout.invalidateLayout()

            }
            
        }
    }

    
}

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return wawos.count
        case 1:
            return kawos.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! WordsCell
        
//        var word : String
//        var backGroundColor : UIColor
//
        switch indexPath.section {
        case 0:
            cell.word = wawos[indexPath.item]
            cell.bubbleContainer.backgroundColor = .systemBackground
            
            return cell
        case 1 :
            cell.word = kawos[indexPath.item]
            cell.bubbleContainer.backgroundColor = UIColor(red: 255 / 255, green: 193 / 255, blue: 213 / 255, alpha: 1)
            return cell
        default:
            return cell
        }
        
    }
    
    /// header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer, for: indexPath) as! ImageHeaderView
        
        
        switch (indexPath.section) {
        case 0:
            
            header.type = .waka
            return header
        case 1:
            
            header.type = .kasu
            
            return header
        default:
            return header
        }
        
        
    }
    
    
    
    
}

extension DetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {


        return UIEdgeInsets(top: 10.0, left: 0, bottom: 50.0, right: 0)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//        let estimatedSizeCell = WordsCell(frame: frame)
//
        var word : String
        
        switch indexPath.section {
        case 0:
            word = wawos[indexPath.item]
        case 1 :
            word = kawos[indexPath.item]
        
        default:
            word = ""
        }
//
        var height: CGFloat = 80 //Arbitrary number
      
            height = estimatedFrameForText(text: word).height + 30
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        
        return CGSize(width: view.frame.width, height: 50)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 250, height: 250)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    
}

extension DetailViewController : DetailHeaderViewDelegate {
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

