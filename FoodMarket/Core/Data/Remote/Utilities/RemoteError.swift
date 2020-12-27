//
//  RemoteError.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

import Foundation

enum RemoteError: LocalizedError {
    case addressUnreachable(String)
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .addressUnreachable(let urlString):
            return "\(urlString) is unreachable."
        case .invalidResponse:
            return "Invalid response."
        }
    }
}
