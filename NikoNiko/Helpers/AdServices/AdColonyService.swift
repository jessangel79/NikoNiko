//
//  AdColonyService.swift
//  NikoNiko
//
//  Created by Angelique Babin on 11/01/2022.
//

import Foundation
import AdColony

final class AdColonyService {
    
    func requestBannerAd1(viewController: UIViewController) {
        AdColony.requestAdView(inZone: "vzb85522c99b784ad1a1", with: kAdColonyAdSizeBanner, viewController: viewController, andDelegate: viewController)
    }
    
    func requestBannerAd2(viewController: UIViewController) {
        AdColony.requestAdView(inZone: "vz6aec3496ad0343b08a", with: kAdColonyAdSizeBanner, viewController: viewController, andDelegate: viewController)
    }
}

//final class AdColonyService: NSObject, AdColonyAdViewDelegate {
//
//    weak var banner: AdColonyAdView?
//    weak var bannerPlacement: UIView!
//
//    func requestBanner(viewController: UIViewController, bannerPlacement: UIView) {
//        AdColony.requestAdView(inZone: "vzb85522c99b784ad1a1", with: kAdColonyAdSizeBanner, viewController: viewController, andDelegate: self)
//    }
//
//    // handle new banner
//    func adColonyAdViewDidLoad(_ adView: AdColonyAdView) {
//        if let oldBanner = self.banner {
//            // remove previous banner if exists
//            oldBanner.destroy()
//        }
//
//        // you can set AdView size to be the same as placement size
//        // AdView will take care about banner centering
//        let placementSize = self.bannerPlacement.frame.size
//        adView.frame = CGRect(x: 0, y: 0, width: placementSize.width, height: placementSize.height)
//
//        // add banner to view
//        self.bannerPlacement.addSubview(adView)
//
//        // store banner reference to be able to clear it later
//        self.banner = adView
//    }
//
//    // handler banner loading failure
//    func adColonyAdViewDidFail(toLoad error: AdColonyAdRequestError) {
//        print("Banner request failed with error: \(error.localizedDescription) and suggestion: \(error.localizedRecoverySuggestion!)")
//    }
//
//    // print AdColony
//    func adColonyAdViewWillOpen(_ adView: AdColonyAdView) {
//        print("AdView will open fullscreen view")
//    }
//
//    func adColonyAdViewDidClose(_ adView: AdColonyAdView) {
//        print("AdView did close fullscreen views")
//    }
//
//    func adColonyAdViewWillLeaveApplication(_ adView: AdColonyAdView) {
//        print("AdView will send used outside the app")
//    }
//
//    func adColonyAdViewDidReceiveClick(_ adView: AdColonyAdView) {
//        print("AdView received a click")
//    }
//}
