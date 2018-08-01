//
//  ResourceRequest.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

typealias HTTPHeader = [String : String]

typealias HTTPBody = [String : Any]

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

protocol ResourceRequest {
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var httpHeader: HTTPHeader? { get }
    
    var paramter: Parameter? { get }
    
}

extension ResourceRequest {
    
    var httpMethod: HTTPMethod { return .GET }
    
    var httpHeader: HTTPHeader? { return nil }
    
    var paramter: Parameter? { return nil }
}

