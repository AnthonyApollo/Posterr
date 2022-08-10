//
//  UIViewController+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit

typealias AlertCallback = () -> Void

extension UIViewController {
    
    func displayActionSheet(
        for title: String,
        and message: String,
        confirmHandler: AlertCallback? = nil,
        cancelHandler: AlertCallback? = nil
    ) {
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        actionSheet.addAction(.init(title: "Cancel", style: .cancel, handler: { _ in cancelHandler?() }))
        actionSheet.addAction(.init(title: "Confirm", style: .default, handler: { _ in confirmHandler?() }))
        
        present(actionSheet, animated: true)
    }
    
    func displayAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(.init(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
    
}
