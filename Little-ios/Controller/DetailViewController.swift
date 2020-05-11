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
    }
    
    //MARK: - UI
    
    private func congifureUI() {
        view.backgroundColor = .lightGray
        
        title = "第\(broadcast.number)回"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
 
}
