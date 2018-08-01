//
//  ParameterEncoding.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

typealias Parameter = [String : Any]

fileprivate struct ParameterEncodingConstants {
    static let contentType = "Content-Type"
    static let urlEncodedFormat = "application/x-www-form-urlencoded; charset=utf-8"
    static let jsonEncodedFormat = "application/json"
}

protocol ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameter) throws
}

struct URLParameterEncoder: ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameter) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems!.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        guard urlRequest.value(forHTTPHeaderField: ParameterEncodingConstants.contentType) == nil else { return }
        
        urlRequest.setValue(ParameterEncodingConstants.urlEncodedFormat, forHTTPHeaderField: ParameterEncodingConstants.contentType)
        
    }
}


struct JSONParameterEncoder: ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameter) throws {
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            
            guard urlRequest.value(forHTTPHeaderField: ParameterEncodingConstants.contentType) == nil else { return }
            urlRequest.setValue(ParameterEncodingConstants.jsonEncodedFormat, forHTTPHeaderField: ParameterEncodingConstants.contentType)
            
            
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
