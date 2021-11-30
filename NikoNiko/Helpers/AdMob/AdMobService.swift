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
        bannerView.adUnitID = Cst.AdMob.AdUnitIDTest // Test
        bannerView.rootViewController = viewController
 //        print("Google Mobile Ads SDK version: \(GADMobileAds.sharedInstance().sdkVersion)")
        bannerView.load(GADRequest())
    }
}
