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
    var result: Double = 0
    var temp: Double = 0
    var state: OperationState = .ideal
    var decimal = false
    var operation: Operation = .none
    
    var resultText = "0"
    var acButtonText =  "AC"
    
    func reset(_ then: ()->()) {
        result = 0
        operation = .none
        acButtonText =  "AC"
        temp = 0
        resultText = "0"
        then()
    }
    
    func plusMinus(_ then: ()->()) {
        temp = temp * (-1)
        resultText = formatToDisplay.string(from: NSNumber(value: temp))!
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
    
    func decimal(_ then: ()->()) {
        
        let currentTemp = formatToCalculateTotal.string(from: NSNumber(value: temp))!
        
        //check if decimal first and second operands both has decimal
        if resultText.contains(AppConstants.decimalSeparator) {
            
        }
        
        if resultText.contains(AppConstants.decimalSeparator) || (state == .ideal && currentTemp.count >= AppConstants.maxLength) {
            return
        }
        
        resultText = currentTemp + AppConstants.decimalSeparator
        decimal = true
        
        then()
    }
    
    func calculate(_  then: ()->()) {
        calculateResult { [unowned self] in
            self.state = .ideal
            self.operation = .none
            then()
        }
    }
    
    private func calculateResult(_ then: ()->()) {
        switch operation {
        case .addiction:
            result = result + temp
            break
        case .subtraction:
            result = result - temp
            break
        case .multiplication:
            result = result * temp
            break
        case .division:
            result = result / temp
            break
        case .percent:
            temp = temp / 100
            result = temp
            break
        case .none:
            break
        }
        
        //formating
        if let currentTotal = formatToCalculateTotal.string(from: NSNumber(value: result)), currentTotal.count > AppConstants.maxLength {
            resultText = formatToDisplayScientific.string(from: NSNumber(value: result))!
        } else {
            resultText = formatToDisplay.string(from: NSNumber(value: result))!
        }
        
        //reset operation needs inspection
        //operation = .none
        
        print("Calculation result is : \(result)")
        
        //update view
        //selectVisualOperation()
        
        then()
        
    }
    
    
}



