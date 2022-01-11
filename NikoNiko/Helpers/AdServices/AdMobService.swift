//
//  AdMobService.swift
//  RoadTrip
//
//  Created by Angelique Babin on 20/05/2021.
//  Copyright © 2021 Angelique Babin. All rights reserved.
//

import UIKit
import GoogleMobileAds

final class AdMobService {

    func setAdMob(_ bannerView: GADBannerView, _ viewController: UIViewController) {
        bannerView.delegate = viewController
        bannerView.adUnitID = Cst.AdMob.AdUnitIDTest
        bannerView.rootViewController = viewController
//         print("Google Mobile Ads SDK version: \(GADMobileAds.sharedInstance().sdkVersion)")
//        bannerView.load(GADRequest())
    }
    
    func loadBannerAd(_ bannerView: GADBannerView, _ view: UIView) { // , _ view: UIView
//        let frame = view.frame.inset(by: view.safeAreaInsets)
//        let viewWidth = frame.size.width
//        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        
//        bannerView.adSize = getFullWidthAdaptiveAdSize(view)
        bannerView.load(GADRequest())
    }
    
    func getFullWidthAdaptiveAdSize(_ view: UIView) -> GADAdSize {
        // Here safe area is taken into account, hence the view frame is used after the
        // view has been laid out.
        let frame = { () -> CGRect in
            if #available(iOS 11.0, *) {
                return view.frame.inset(by: view.safeAreaInsets)
            } else {
                return view.frame
            }
        }()
        return GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(frame.size.width)
    }

}
