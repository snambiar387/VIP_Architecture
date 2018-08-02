//
//  ActivityIndicatorLoadable.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 02/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import UIKit

protocol ActivityIndicatorLoadable {
    
    func showActivityIndicator()
    
     func hideActivityIndicator()
}

extension ActivityIndicatorLoadable where Self: UIViewController {
    
    func showActivityIndicator() {
        print("Show Activity indicator")
    }
    
    func hideActivityIndicator() {
        print("Hide Activity indicator")
    }
}
