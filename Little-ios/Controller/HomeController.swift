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
    
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .red
        
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
    
    private func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.anchor(top : view.safeAreaLayoutGuide.topAnchor,paddingTop: 150)
        
        view.addSubview(timeLabel)
        
        timeLabel.centerX(inView: view)
        timeLabel.anchor(top : logoImageView.bottomAnchor,paddingTop: 30)
        


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
        
//        var eventDateComponents = DateComponents()
//        eventDateComponents.year = 2020
//        eventDateComponents.month = 05
//        eventDateComponents.day = 17
//        eventDateComponents.hour = 01
//        eventDateComponents.minute = 00
//        eventDateComponents.second = 00
//        eventDateComponents.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        let eventDate = userCalender.date(from: sundayDatecomponents)!
        let timeLeft = userCalender.dateComponents([.hour,.month,.year,.day,.minute,.second], from: currentDate, to: eventDate)
        
        timeLabel.text = "\(timeLeft.day!)d \(timeLeft.hour!)h \(timeLeft.minute!)m \(timeLeft.second!)s"
        
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

