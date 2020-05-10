//
//  SideMenuController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "SidemMenuCell"

enum MenuOptions : Int, CaseIterable, CustomStringConvertible {
    
    case broadcats
    
    var description : String {
        switch self {
        case .broadcats:
            return "放送回"
       
        }
    }
    
}

protocol SideMenuControllerDelegate {
    func didSelect(type : MenuOptions)
}

class SideMenuController : UITableViewController {
    
    var delegate : SideMenuControllerDelegate?
    
    private lazy var sideMenuHerader : UIView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 200)
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        
        
    }
}

extension SideMenuController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        
        guard let type = MenuOptions(rawValue: indexPath.row) else {return UITableViewCell()}
        
        cell.textLabel?.text = type.description
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        print("Touch")
        guard let type = MenuOptions(rawValue: indexPath.row) else {return}
        
       

        switch type {
        case .broadcats:

            delegate?.didSelect(type: type)
        default:
            return
        }
    }
    

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = .yellow
        cell.textLabel?.textColor = .black
        cell.textLabel?.textAlignment = .center
    }
    
    
    
    
}
