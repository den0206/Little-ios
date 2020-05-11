//
//  DetailViewController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    let broadcast : Broadcast
    
    
    
    //MARK: - Parts
    
    lazy var headerView : DetailHeaderView = {
        let view = DetailHeaderView()
        view.delegate = self
        view.broadcast = self.broadcast
        return view
    }()
    
    var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .red
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
        
//        setParameter()
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
    
//    private func setParameter() {
//
//        let url = URL(string: broadcast.image)
//        imageView.sd_setImage(with: url)
//    }

    
    //MARK: - UI
    
    private func congifureUI() {
        view.backgroundColor = .lightGray
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        view.addSubview(headerView)


        collectionView.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: view.frame.height)

        view.addSubview(collectionView)
    }

    
}

extension DetailViewController : DetailHeaderViewDelegate {
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

