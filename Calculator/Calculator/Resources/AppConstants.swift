//
//  AppConstants.swift
//  Calculator
//
//  Created by Admin on 29/6/20.
//  Copyright © 2020 Devi Prasad Ghimire. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    
    static var decimalSeparator: String {
        return Locale.current.decimalSeparator!
    }
    
    static var maxLength: Int {
        return  9
    }
    
    static var total: String {
        return "TOTAL"
    }
    
    
    struct Color {
        static var orange: UIColor {
            return #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        }
        static var white: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
                
    }
}


