//
//  NetworkRouter.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

protocol NetworkRouter: class {
    
    func request(_ resource: ResourceRequest, completion: @escaping NetworkRouterCompletion)
    
    func cancel()
    
}
