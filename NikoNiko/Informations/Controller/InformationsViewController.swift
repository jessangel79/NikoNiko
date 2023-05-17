//
//  InformationsViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 29/11/2021.
//

import UIKit
// import GoogleMobileAds
import AdColony

final class InformationsViewController: UIViewController {
    
    // MARK: - Outlets

//    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var bannerPlacement: UIView!

    // MARK: - Properties

    private let badgeLinkedIn = "https://www.linkedin.com/in/ang%C3%A9lique-babin-158aa874/?original_referer="
    // "https://www.linkedin.com/mwlite/in/ang%C3%A9lique-babin-158aa874"
    private let pngTree = "https://pngtree.com/so/Avion"
    private let angelAppDev = "https://www.angelappdev.io"
    private var urlString = String()
//    private let adMobService = AdMobService()
    private weak var banner: AdColonyAdView?
    private var adColonyService = AdColonyService()

    // MARK: - Actions

    @IBAction private func pngTreeButtonTapped(_ sender: UIButton) {
        openWebView(pngTree)
    }

    @IBAction private func angelAppDevButtonTapped(_ sender: UIButton) {
        openWebView(angelAppDev)
    }

    @IBAction private func badgeProButtonTapped(_ sender: UIButton) {
        openWebView(badgeLinkedIn)
    }
    
    @IBAction func closeModalBarButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true
        setUserInterfaceStyle()
        
        adColonyService.destroyAd() // TEST
        adColonyService.requestBannerAd(Cst.AdColony.Banner2, self) // 2

//        adMobService.setAdMob(bannerView, self)
//        adViewDidReceiveAd(bannerView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = true
        setUserInterfaceStyle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        adMobService.loadBannerAd(bannerView, view)
    }

    // MARK: - Methods

    private func openWebView(_ urlString: String) {
        self.urlString = urlString
        performSegue(withIdentifier: Cst.Segue.ToWebsiteInfo, sender: self)
    }
}

// MARK: - Navigation

extension InformationsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Cst.Segue.ToWebsiteInfo {
            guard let websiteInfoVC = segue.destination as? WebViewInformationsViewController else { return }
            websiteInfoVC.urlString = self.urlString
        }
    }
}

// MARK: - Extension AdColony AdView Delegate

extension InformationsViewController {
    override func adColonyAdViewDidLoad(_ adView: AdColonyAdView) {
        if let oldBanner = self.banner {
            oldBanner.destroy()
        }
        let placementSize = self.bannerPlacement.frame.size
        adView.frame = CGRect(x: 0, y: 0, width: placementSize.width, height: placementSize.height)
        self.bannerPlacement.addSubview(adView)
        self.banner = adView
    }
}
