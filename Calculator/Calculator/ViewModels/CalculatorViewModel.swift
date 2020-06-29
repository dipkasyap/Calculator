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
    
}



