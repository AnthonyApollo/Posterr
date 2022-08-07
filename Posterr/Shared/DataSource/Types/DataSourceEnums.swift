//
//  DataSourceEnums.swift
//  Posterr
//
//  Created by Anthony Apollo on 07/08/22.
//

import Foundation

enum RequestResult<T> {
    
    case success(T)
    case failure(RequestError)
    
}

enum RequestError: LocalizedError, Identifiable {
    
    var id: String { errorDescription }
  
    case fetchError
    case invalidData
    case saveError
  
    var errorDescription: String {
        switch self {
        case .fetchError:
            return "An error occurred while retrieving server information."
        case .invalidData:
            return "Invalid data format."
        case .saveError:
            return "An error occurred while saving data."
        }
    }
    
}
