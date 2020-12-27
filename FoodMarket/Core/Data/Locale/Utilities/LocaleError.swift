//
//  LocaleError.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

import Foundation

enum LocaleError: LocalizedError {
    case invalidInstance
    case requestFailed

    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Can't create database instance."
        case .requestFailed: return "Your request failed."
        }
    }
}
