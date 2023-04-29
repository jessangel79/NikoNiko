//
//  UIViewController+Alert.swift
//
//  Created by Angelique Babin on 10/02/2020.
//  Copyright © 2020 Angelique Babin. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - Extension to display an alert message to the user

extension UIViewController: UITextFieldDelegate {
    
    /// Enumeration of the error
    enum AlertError {
        case noWebsite
        case noStartDate
        case noEndDate
        case errorDate
    }
    
    /// Alert message for user
    func presentAlert(typeError: AlertError) {
        var message: String
        var title: String
      
        switch typeError {
        case .noWebsite:
            title = "No website"
            message = "Sorry there is no website for this place."
        case .noStartDate:
            title = "No start date"
            message = "Please to set a start date."
        case .noEndDate:
            title = "No end date"
            message = "Please to set an end date."
        case .errorDate:
            title = "Error date"
            message = "Please to set correct start and end dates."
        }
        
        alertError(title, message)
    }
    
    /// Base of alert for custom action
    private func alertCustomAction(_ title: String, _ message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func alertError(_ title: String, _ message: String) {
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertCustomAction(title, message, action: action)
    }
    
    /// Alert message for user to confirm all reset
    func showResetAlert(destructiveAction: UIAlertAction) {
        let alert = UIAlertController(title: "Warning Reset All", message: "Are you sure to reset all ?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(destructiveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    /// Display an alert to enter a comment for today
    func displayAddCommentAlert(handlerAddComment: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "Do you have a comment to add ?", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter your comment"
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            textField.autocapitalizationType = .sentences
        }
        let action = UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let textField = alertController.textFields else { return }
            handlerAddComment(textField.first?.text)
            // To delete
            print("textfield")
            print(textField.first?.text ?? "error text")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(action)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > 30 {
            textField.deleteBackward()
        }
    }
}
