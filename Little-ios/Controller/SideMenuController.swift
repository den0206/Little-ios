//
//  SideMenuController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class SideMenuController : UITableViewController {
    
    private lazy var sideMenuHerader : UIView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 140)
        let view = UIView(frame: frame)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        
    }
    
    private func configureTableView() {
        
        tableView.backgroundColor = .yellow
        tableView.separatorStyle = .none
        
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        tableView.tableHeaderView = sideMenuHerader
        
    }
}
