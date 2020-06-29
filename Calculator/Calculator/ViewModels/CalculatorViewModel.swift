//
//  Calculatorswift
//  Calculator
//
//  Created by Admin on 29/6/20.
//  Copyright © 2020 Devi Prasad Ghimire. All rights reserved.
//

import Foundation

enum Operation {
    case none, addiction, subtraction, multiplication, division, percent
}

enum OperationState {
    case operating, ideal
}

class CalculatorViewModel {
    var total: Double = 0
    var temp: Double = 0
    var state: OperationState = .ideal
    var decimal = false
    var operation: Operation = .none
    
    var resultText = "0"
    var acButtonText =  "AC"
    
    func reset(_ then: ()->()) {
        total = 0
        operation = .none
        acButtonText =  "AC"
        temp = 0
        resultText = "0"
        then()
    }
    
    func add(_ then: ()->()) {
        if operation != .none {
            calculateResult {
                then()
            }
        }
        state = .operating
        operation = .addiction
    }
    
    func subtract(_ then: ()->()) {
        if operation != .none {
            calculateResult {
                then()
            }
        }
        state = .operating
        operation = .subtraction
    }
    
    func multiply(_ then: ()->()) {
        if operation != .none {
            calculateResult {
                then()
            }
        }
        state = .operating
        operation = .multiplication
    }
    
    func devide(_ then: ()->()) {
           
           if operation != .none {
               calculateResult {
                   then()
               }
        }
           state = .operating
           operation = .division
       }
    
    func percent(_ then: ()->()) {
           if operation != .percent {
               calculateResult {
                   then()
               }
           }
           state = .operating
           operation = .percent
           calculateResult {
               then()
           }
       }
    
    private func calculateResult(_ then: ()->()) {
        switch operation {
        case .addiction:
            total = total + temp
            break
        case .subtraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        case .none:
            break
        }
        
        //formating
        if let currentTotal = formatToCalculateTotal.string(from: NSNumber(value: total)), currentTotal.count > AppConstants.maxLength {
            resultText = formatToDisplayScientific.string(from: NSNumber(value: total))!
        } else {
            resultText = formatToDisplay.string(from: NSNumber(value: total))!
        }
        
        //reset operation
        operation = .none
        
        
        UserDefaults.standard.set(total, forKey: AppConstants.total)
        
        print("Calculation result is : \(total)")
        
        //update view
        //selectVisualOperation()
        
    }
    
    
}



