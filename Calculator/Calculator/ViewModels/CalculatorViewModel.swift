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

enum NumberTag: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
}

class CalculatorViewModel {
    
    var result: Double = 0
  
    var temp: Double = 0
    var state: OperationState = .ideal
    var operation: Operation = .none
  
    var decimal = false

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
    
    func didPressedNumberWithTag(_ numberTag: NumberTag, then: ()->()) {
                   
           acButtonText = "C"
           
           var currentTemp = formatToCalculateTotal.string(from: NSNumber(value: temp))!
           
           if state == .ideal && currentTemp.count >= AppConstants.maxLength {
               return
           }
           
           currentTemp = formatToCalculate.string(from: NSNumber(value: temp))!
           
           //on operation
           if state == .operating {
               result = result == 0 ? temp : result
               resultText = ""
               currentTemp = ""
               state = .ideal
           }
           
           // on decimal
           if decimal {
               currentTemp = "\(currentTemp)\(AppConstants.decimalSeparator)"
               decimal = false
           }
           
            let number = numberTag.rawValue
           temp = Double(currentTemp + String(number))!
           resultText = formatToDisplay.string(from: NSNumber(value: temp))!
           
           //updateOperatorButtonsAppearance()
        
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



