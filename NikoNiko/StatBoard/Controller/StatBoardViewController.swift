//
//  StatBoardViewController.swift
//  NikoNiko
//
//  Created by Angelique Babin on 03/12/2021.
//

import UIKit
// import GoogleMobileAds
import AdColony

final class StatBoardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var baseView: UIView!
    @IBOutlet private weak var fromDateTextField: UITextField!
    @IBOutlet private weak var toDateTextField: UITextField!
    @IBOutlet private weak var statTableView: UITableView! {
        didSet { statTableView.tableFooterView = UIView() }
    }
//    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var bannerPlacement: UIView!

    // MARK: - Properties
    
    private var statMoodTupleList = [(nameMood: String, statMood: Int)]()
    private var adColonyService = AdColonyService()
//    private let adMobService = AdMobService()
    
    // MARK: - Actions
    
    @IBAction func searchBarButtonItemPressed(_ sender: UIBarButtonItem) {
        getStatMoodToPeriod()
        statTableView.reloadData()
    }
    
    @IBAction func refreshBarButtonItemPressed(_ sender: UIBarButtonItem) {
        setDefaultDatesTextField()
        statMoodTupleList.removeAll()
        statTableView.reloadData()
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromDateTextField.delegate = self
        toDateTextField.delegate = self
        setApp()
        
        adColonyService.destroyAd()
        adColonyService.requestBannerAd(Cst.AdColony.Banner1, self) // 1
        adColonyService.requestInterstitial(Cst.AdColony.Interstitial, self)
//        adMobService.setAdMob(bannerView, self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserInterfaceStyle()
        statTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adColonyService.showAd(self)
    }

    // MARK: - Methods
    
    private func setApp() {
        setDefaultDatesTextField()
        setDatePicker()
        setTableView()
        setUserInterfaceStyle()
    }
    
    private func setDefaultDatesTextField() {
        fromDateTextField.text = Date().addingTimeInterval(-(Double(24 * 60 * 60 * 30))).toString(format: FormatDate.onDisplay.rawValue)
        toDateTextField.text = Date().toString(format: FormatDate.onDisplay.rawValue)
    }
    
    private func setDatePicker() {
        self.fromDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDoneFromDate))
        self.toDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDoneToDate))
    }

    private func setTableView() {
        statTableView.delegate = self
        statTableView.dataSource = self
        statTableView.register(StatTableViewCell.nib, forCellReuseIdentifier: StatTableViewCell.identifier)
        statTableView.reloadData()
    }

    private func getStatMoodToPeriod() {
        guard let fromDateStr = fromDateTextField.text, !fromDateStr.isBlank else { return presentAlert(typeError: .noStartDate) }
        guard let toDateStr = toDateTextField.text, !toDateStr.isBlank else { return presentAlert(typeError: .noEndDate) }
        let fromDate = fromDateStr.toDate(format: FormatDate.onDisplay.rawValue)
        let toDate = toDateStr.toDate(format: FormatDate.onDisplay.rawValue)
        if checkIfDateCorrect(fromDate, toDate) {
            let dataManager = DataManager()
            statMoodTupleList = dataManager.createStatMoodTupleList(fromDate, toDate)
        }
    }
    
    private func checkIfDateCorrect(_ fromDate: Date, _ toDate: Date) -> Bool {
        if toDate < fromDate {
            presentAlert(typeError: .errorDate)
            return false
        }
        return true
    }
    
}

// MARK: - UITableViewDataSource

extension StatBoardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statMoodTupleList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let statTableViewCell = tableView.dequeueReusableCell(withIdentifier: StatTableViewCell.identifier,
                                                                    for: indexPath) as? StatTableViewCell else {
            return UITableViewCell()
        }
        statTableViewCell.setupCellWithTuple(indexPath, statMoodTupleList)
        return statTableViewCell
    }
}

// MARK: - UITableViewDelegate

extension StatBoardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Set Dates and click on search to get stats of Moods"
        label.font = UIFont(name: "Monaco", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = UIColor.appColor(.fontColor)
        label.backgroundColor = UIColor.appColor(.backGroundColor)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return statMoodTupleList.isEmpty ? 300 : 0
    }
}

// MARK: - DatePicker

extension StatBoardViewController {
    
    @objc func tapDoneFromDate() {
        if let datePicker = self.fromDateTextField.inputView as? UIDatePicker {
            self.fromDateTextField.text = setSelectedDate(datePicker: datePicker)
        }
        self.fromDateTextField.resignFirstResponder()
    }
    
    @objc func tapDoneToDate() {
        if let datePicker = self.toDateTextField.inputView as? UIDatePicker {
            self.toDateTextField.text = setSelectedDate(datePicker: datePicker)
         }
        self.toDateTextField.resignFirstResponder()
        self.getStatMoodToPeriod()
        self.statTableView.reloadData()
    }
    
    private func setSelectedDate(datePicker: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatDate.onDisplay.rawValue
        dateFormatter.dateStyle = .short
        let selectedDate = dateFormatter.string(from: datePicker.date)
//        print("Selected value \(selectedDate)")
        return selectedDate
    }
}

// MARK: - Keyboard - UITextFieldDelegate

extension StatBoardViewController {
    
    @IBAction func dismissKeyBoardTapGesture( _ sender: UITapGestureRecognizer) {
        fromDateTextField.resignFirstResponder()
        toDateTextField.resignFirstResponder()
    }
}

// MARK: - Extension AdColony Interstitial Delegate

extension StatBoardViewController {
    
    override func adColonyInterstitialDidLoad(_ interstitial: AdColonyInterstitial) {
        adColonyService.interstitial = interstitial
    }
    
    // Handle loading error
    override func adColonyInterstitialDidFail(toLoad error: AdColonyAdRequestError) {
        print("Interstitial request failed with error: \(error.localizedDescription) and suggestion: \(error.localizedRecoverySuggestion!)")
    }
    
    // Handle expiring ads (optional)
    override func adColonyInterstitialExpired(_ interstitial: AdColonyInterstitial) {
        adColonyService.interstitial = nil
        adColonyService.requestInterstitial(Cst.AdColony.Interstitial, self)
    }
}

// MARK: - Extension AdColony AdView Delegate

extension StatBoardViewController {
    override func adColonyAdViewDidLoad(_ adView: AdColonyAdView) {
        adColonyService.destroyAd()
        let placementSize = self.bannerPlacement.frame.size
        adView.frame = CGRect(x: 0, y: 0, width: placementSize.width, height: placementSize.height)
        self.bannerPlacement.addSubview(adView)
        adColonyService.banner = adView
    }
}
