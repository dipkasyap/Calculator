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
    
    struct Color {
        static var white: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        static var lightGray: UIColor {
            return #colorLiteral(red: 0.8313056827, green: 0.83156991, blue: 0.8231052756, alpha: 1)
        }
        static var eerieBlack: UIColor {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        static var darkLiver: UIColor {
            return #colorLiteral(red: 0.3136876225, green: 0.313747257, blue: 0.3136838675, alpha: 1)
        }
        static var vividGamboge: UIColor {
            return #colorLiteral(red: 1, green: 0.5825584531, blue: 0, alpha: 1)
        }
    }
}


