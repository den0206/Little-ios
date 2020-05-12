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
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        view.addSubview(headerView)
        

        collectionView.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: view.frame.height)

        view.addSubview(collectionView)
    }
    
    private func configureCV() {
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.register(WordHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer)
        collectionView.isScrollEnabled = true
        
        collectionView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        collectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    
    }
    
    //MARK: - API
    
    private func fetchWords() {
        APIManager.shared.oneCastRequest(number: broadcast.number) { (words, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                self.showErrorAlert(message: error!.localizedDescription)
            }
            
            guard let words = words else {return}
            
            self.wawos = words.wawos
            self.kawos = words.kawos
            
            self.collectionView.reloadData()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath)
        
        cell.backgroundColor = .white
        return cell
    }
    
    /// header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer, for: indexPath) as! WordHeaderView
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            switch (indexPath.section) {
            case 0:
                header.word = broadcast.waka
                header.type = .waka
                
                return header
            case 1:
                header.word = broadcast.kasu

                header.type = .kasu
                
                return header
            default:
                return header
            }
        }
        
        return UICollectionReusableView()
     
    }
    
    
    
    
}

extension DetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {


        return UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

extension DetailViewController : DetailHeaderViewDelegate {
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

