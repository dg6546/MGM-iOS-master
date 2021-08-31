//
//  Errors.swift
//  MGM
//
//  Created by user-1 on 18/6/2021.
//

import Foundation

enum CustomError: LocalizedError, Identifiable{
    case invalidCredentials
    case invalidURL
    case noData
    case jsonSeperation
    case decodingError
    case connectionError
    case notAuthenticated
    case custom(errorMessage: String)
    
    var id: String { localizedDescription }
    
    var errorDescription: String?{
        switch self {
        case .invalidCredentials:
            return "Credentials error. Please re-enter email or password."
        case .connectionError:
            return "Cannot connect to server. (Network error)"
        case .invalidURL:
            return "Cannot connect to server (API error)"
        case .noData:
            return "Cannot receive data from server."
        case .decodingError:
            return "failed to decode data from server"
        case .custom(errorMessage: let errorMessage):
            return errorMessage
        case .jsonSeperation:
            return "Json seperation error"
        case .notAuthenticated:
            return "Not authenticated"
        }
    }
}

