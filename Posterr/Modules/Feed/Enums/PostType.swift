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
            return UIImage(systemName: "bubble.left.and.bubble.right")!
        case .quotePost:
            return UIImage(systemName: "quote.bubble")!
        }
    }
    
}
