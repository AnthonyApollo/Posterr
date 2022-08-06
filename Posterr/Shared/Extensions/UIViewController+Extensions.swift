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
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: { _ in cancelHandler?() }))
        alert.addAction(.init(title: "Confirm", style: .default, handler: { _ in confirmHandler?() }))
        
        present(alert, animated: true)
    }
    
}
