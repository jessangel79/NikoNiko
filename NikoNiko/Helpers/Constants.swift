//
//  Constants.swift
//  SunsetApp
//
//  Created by Angelique Babin on 08/11/2021.
//

import Foundation

struct Cst {

    static let nbOfMoods = 20

    struct AdMob {
        static let AdUnitIDTest = "ca-app-pub-3940256099942544/2934735716"
        static let AdUnitIDProd = "ca-app-pub-1785702102693747/5166484662"
    }
    
    struct Segue {
        static let ToWebsiteInfo = "segueToWebsiteInfo"
        static let ToMoodBoard = "segueToMoodBoard"
    }
    
    struct AdColony {
        static let AppUUID = valueForUUIDKey(named: "AdColonyAppUUID")
        static let Banner1 = "vzb85522c99b784ad1a1"
        static let Banner2 = "vz6aec3496ad0343b08a"
        static let Interstitial = "vzf7d1df791b5446a5b7"
        static let BannerMediumRect = "vz9c33d64665964a36be"
        // "vzb85522c99b784ad1a1", "vz6aec3496ad0343b08a", "vzf7d1df791b5446a5b7"
    }
}
