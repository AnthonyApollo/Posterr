//
//  PostType.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit

enum PostType {
    
    case post, repost, quotePost
    
    var icon: UIImage {
        switch self {
        case .post:
            //TODO: Remove force unwrap
            return UIImage(systemName: "text.bubble")!
        case .repost:
            return UIImage(systemName: "plus.bubble")!
        case .quotePost:
            return UIImage(systemName: "quote.bubble")!
        }
    }
    
    var messageViewBackgroundColor: UIColor {
        switch self {
        case .post:
            return .white
        default:
            return .systemGray6
        }
    }
    
    var messageViewCornerRadius: CGFloat {
        switch self {
        case .post:
            return 0
        default:
            return 5
        }
    }
    
}
