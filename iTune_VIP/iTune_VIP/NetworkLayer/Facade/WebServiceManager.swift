//
//  WebServiceManager.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

/*
    This could be an implementation conforming to protocols like DataRequestable, Downloadable and Uploadable(depending on requirements)
*/

class WebServiceManager {
    
    private let router: NetworkRouter
    
    init(router: NetworkRouter = URLSessionRouter()) {
        self.router = router
    }
    
    func request(_ resource: ResourceRequest, completion: @escaping NetworkRouterCompletion) {
        
        router.request(resource) { (result) in
            
            completion(result)
        }
    }
}
