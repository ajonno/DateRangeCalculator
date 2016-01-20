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

enum Month : Int {
    case Jan = 1
    case Feb = 2
    case Mar = 3
    case Apr = 4
    case May = 5
    case Jun = 6
    case Jul = 7
    case Aug = 8
    case Sep = 9
    case Oct = 10
    case Nov = 11
    case Dec = 12
    
    static let allValues = [Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec]
    
}

let screenBounds = UIScreen.mainScreen().bounds