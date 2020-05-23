//
//  AdMobHelper.swift
//  Little-ios
//
//  Created by 酒井ゆうき on 2020/05/21.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import GoogleMobileAds


let admob_test = true


class AdMobHelper : NSObject {
    
    static let shared = AdMobHelper()
    
    func initSDK() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    func setupBannerAd(adBaseView : UIView, rootVC : UIViewController,bannerId : String) {
        let adView = GADBannerView(adSize: kGADAdSizeBanner)
        adView.adUnitID = bannerId

        
        adView.rootViewController = rootVC
        adView.load(GADRequest())
        adBaseView.addSubview(adView)
    }
    
    
    
    
    
}
