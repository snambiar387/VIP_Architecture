//
//  Router.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion = (Result<Data>)->()


enum Result<T> {
    case error(Error)
    case success(T)
}

class URLSessionRouter: NetworkRouter {
    
    func request(_ resource: ResourceRequest, completion: @escaping NetworkRouterCompletion) {
        
        guard let urlRequest = constructURLRequest(from: resource) else { return }
        
        urlRequest.send { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func cancel() {
        
    }
    
    fileprivate func constructURL(from request: ResourceRequest) -> URL? {
        
        return URL(string: request.baseURL + request.path)
    }
    
    fileprivate func constructURLRequest(from request: ResourceRequest) -> URLRequest? {
        
        guard let url = constructURL(from: request) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        if let paramter = request.paramter {
            switch request.httpMethod {
            case .GET:
                try! URLParameterEncoder.encode(urlRequest: &urlRequest, with: paramter)
            case .POST:
                try! JSONParameterEncoder.encode(urlRequest: &urlRequest, with: paramter)
            default: break
            }
        }
        
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        return urlRequest
    }
}

extension URLRequest {
    
    func send(completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared.dataTask(with: self) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.error(NetworkError.noData))
                return
            }
            
            switch response.validate() {
                
            case .error(let networkError):
                completion(.error(networkError))
                return
                
            case .success( _):
                guard let data = data else {
                    completion(.error(NetworkError.noData))
                    return
                }
                completion(.success(data))
            }
        }
        
        session.resume()
    }
}

extension HTTPURLResponse {
    
    func validate()-> Result<HTTPURLResponse> {
        
        switch statusCode {
        case 200...299: return .success(self)
        case 401...500: return .error(NetworkError.authenticationError)
        case 501...599: return .error(NetworkError.badRequest)
        case 600: return .error(NetworkError.outdated)
        default: return .error(NetworkError.failed)
        }
    }
}
