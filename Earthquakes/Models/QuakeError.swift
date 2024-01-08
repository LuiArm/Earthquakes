//
//  QuakeError.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/8/23.
//

import Foundation

enum QuakeError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case.missingData:
            return NSLocalizedString("Found and will discard a quake missing a valid code, magnitude, place, or time.", comment: "")
        case.networkError:
            return NSLocalizedString("There is a network error", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Recieved unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}
