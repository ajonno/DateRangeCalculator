//
//  Extensions.swift
//  DateRangeCalculator
//
//  Created by Angus Johnston on 20/01/2016.
//  Copyright © 2016 Angus Johnston. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

