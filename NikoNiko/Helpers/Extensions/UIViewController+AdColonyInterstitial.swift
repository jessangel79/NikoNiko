//
//  UIViewController+AdColonyInterstitial.swift
//  NikoNiko
//
//  Created by Angelique Babin on 12/01/2022.
//

import Foundation
import AdColony

// MARK: - Extension AdColony Interstitial Delegate - All UIViewController

extension UIViewController: AdColonyInterstitialDelegate {
    
    // Store a reference to the returned interstitial object
    public func adColonyInterstitialDidLoad(_ interstitial: AdColonyInterstitial) {}
    
    // Handle loading error
    public func adColonyInterstitialDidFail(toLoad error: AdColonyAdRequestError) {
        print("Interstitial request failed with error: \(error.localizedDescription) and suggestion: \(error.localizedRecoverySuggestion!)")
    }
    
    // Handle expiring ads (optional)
    public func adColonyInterstitialExpired(_ interstitial: AdColonyInterstitial) {}
    
    public func adColonyInterstitialWillOpen(_ interstitial: AdColonyInterstitial) {
        print("Interstitial will open")
    }
    
    public func adColonyInterstitialDidClose(_ interstitial: AdColonyInterstitial) {
        print("Interstitial did close")
    }
    
    public func adColonyInterstitialWillLeaveApplication(_ interstitial: AdColonyInterstitial) {
        print("Interstitial will send user out of application")
    }
    
    public func adColonyInterstitialDidReceiveClick(_ interstitial: AdColonyInterstitial) {
        print("Interstitial did receive a click")
    }
}
