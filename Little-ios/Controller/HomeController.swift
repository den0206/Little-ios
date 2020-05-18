//
//  HomeController.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol HomeControllerDelegate : class {
    func handleSideMenu()
}

class HomeController : UIViewController {
    
    var delagate : HomeControllerDelegate?
    
    var sundayDatecomponents : DateComponents!
    //MARK: - parts
    
    //    private lazy var centerImageView : UIImageView = {
    //        let iv = UIImageView()
    //        iv.image = #imageLiteral(resourceName: "Audly")
    //        iv.contentMode = .scaleAspectFit
    //        iv.setDimension(width: self.view.frame.width, height: 500)
    //        return iv
    //    }()
    
    private let logoImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "little")
        iv.setDimension(width: 250, height: 250)
        return iv
    }()
    
    private let nextlabel : UILabel = {
        let label = UILabel()

        label.text = "次の放送まで"
        label.font = UIFont(name: "851CHIKARA-DZUYOKU-KANA-A", size: 27.0)
        label.textColor = .red
        label.numberOfLines = 2
        label.layoutMargins.bottom = 2.0
        label.textAlignment = .center
        
        return label
    }()
    

    private let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = UIFont(name: "Palatino", size: 27.0)
        label.textColor = .red
        label.numberOfLines = 2
        label.layoutMargins.bottom = 2.0
        label.textAlignment = .center
        
        return label
    }()
    
    var timer : Timer?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        sundayDatecomponents = getNextRadio()
    
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(configureTimer), userInfo: nil, repeats: true)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.anchor(top : view.topAnchor,paddingTop: 100)
        
   
        let timerStack = UIStackView(arrangedSubviews: [nextlabel,timeLabel])
        timerStack.axis = .vertical
        timerStack.spacing = 20

        view.addSubview(timerStack)
        timerStack.centerX(inView: view)
        timerStack.anchor(top : logoImageView.bottomAnchor, paddingTop: 20)



    }
    
    private func getNextRadio() -> DateComponents {
        
        let sunday = Date.today().next(.sunday)
        var compoents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: sunday)
        
        compoents.hour = 01
        compoents.minute = 00
        compoents.second = 00
        compoents.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        return compoents
    }
    
    @objc func configureTimer() {
        let userCalender = Calendar.current
        let date = Date()
        let compnents = userCalender.dateComponents([.hour,.month,.year,.day,.minute, .second], from: date)
        let currentDate = userCalender.date(from: compnents)!
        
//        sundayDatecomponents.hour = 01
//        sundayDatecomponents.minute = 00
//        sundayDatecomponents.second = 00
//        sundayDatecomponents.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        
        let eventDate = userCalender.date(from: sundayDatecomponents)!
        let timeLeft = userCalender.dateComponents([.hour,.month,.year,.day,.minute,.second], from: currentDate, to: eventDate)
        
        if timeLeft.day == 7 {
            timeLabel.text = "0 Days, \(timeLeft.hour!) Hour,\n\(timeLeft.minute!) Minutes, \(timeLeft.second!) Secounds."

        } else {
            timeLabel.text = "\(timeLeft.day!) Days, \(timeLeft.hour!) Hour,\n\(timeLeft.minute!) Minutes, \(timeLeft.second!) Secounds."

        }
        
        
        endEvent(currentDate: currentDate, eventDate: eventDate)
        
    }
    
    func endEvent(currentDate : Date, eventDate : Date) {
        if currentDate >= eventDate {
            
            timeLabel.text = "Now ON AIR!"
            timer?.invalidate()
        }
    }
    
    @objc func sideMenuTapped() {
        
        delagate?.handleSideMenu()
    }

    
}

extension HomeController : MainTabControllerDelegate {
    func didSelectTab(tabBarController: UITabBarController) {
        
        sundayDatecomponents = getNextRadio()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(configureTimer), userInfo: nil, repeats: true)
        
    }
    
    
}

