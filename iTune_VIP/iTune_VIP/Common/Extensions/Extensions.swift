//
//  Extensions.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 02/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSimpleAlertWith(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

