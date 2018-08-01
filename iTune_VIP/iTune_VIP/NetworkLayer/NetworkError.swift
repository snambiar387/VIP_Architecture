//
//  NetworkError.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    
    case parametersNil = "No params"
    case encodingFailed = "Encoding Failed"
    case missingURL = "No URL found"
    case authenticationError = "You are not authorised"
    case badRequest = "Bad request"
    case outdated = "Outdated URL"
    case failed = "Network request failed"
    case noData = "Returnde with no data"
    case decodeError = "Unable to decode"
}
