//
//  HomeController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class HomeController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        fetchBroadcast()
        
        
    }
    
    private func fetchBroadcast() {
        APIManager.shared.oneCastRequest(number: 4) { (broadcast, error) in

            guard var broadcast = broadcast else {return}
            broadcast.wawos.append(broadcast.snippet.waka)
            print(broadcast.wawos)
        }

        APIManager.shared.allCastsRequest { (index, error) in
            guard let index = index else {return}
            /// self.nextPageToken = index.pagenation.pagenation.next
            print(index.broadcats.count)
        }
    }
    
    
}
