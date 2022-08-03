//
//  FeedViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    private let feedView: FeedView = .init()
    
    override func loadView() {
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
