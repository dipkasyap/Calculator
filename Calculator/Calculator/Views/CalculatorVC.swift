//
//  CalculatorVC.swift
//  Calculator
//
//  Created by Devi Prasad Ghimire on 26/6/20.
//  Copyright © 2020 Devi Prasad Ghimire. All rights reserved.
//

import UIKit

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

class CalculatorVC: UIViewController {
    
    //result label
    @IBOutlet weak var resultLabel: UILabel!
    
    // Number Buttons
    @IBOutlet weak var buttonOne: CalculatorButton! {
        didSet {
            buttonOne.tag = NumberTag.one.rawValue
        }
    }
    @IBOutlet weak var buttonTwo: CalculatorButton!{
        didSet {
            buttonTwo.tag = NumberTag.two.rawValue
        }
    }
    @IBOutlet weak var buttonThree: CalculatorButton!{
        didSet {
            buttonThree.tag = NumberTag.three.rawValue
        }
    }
    @IBOutlet weak var buttonFour: CalculatorButton!{
        didSet {
            buttonFour.tag = NumberTag.four.rawValue
        }
    }
    @IBOutlet weak var buttonFive: CalculatorButton!{
        didSet {
            buttonFive.tag = NumberTag.five.rawValue
        }
    }
    @IBOutlet weak var buttonSix: CalculatorButton!{
        didSet {
            buttonSix.tag = NumberTag.six.rawValue
        }
    }
    @IBOutlet weak var buttonSeven: CalculatorButton!{
        didSet {
            buttonSeven.tag = NumberTag.seven.rawValue
        }
    }
    @IBOutlet weak var buttonEight: CalculatorButton!{
        didSet {
            buttonEight.tag = NumberTag.eight.rawValue
        }
    }
    @IBOutlet weak var buttonNine: CalculatorButton!{
        didSet {
            buttonNine.tag = NumberTag.nine.rawValue
        }
    }
    @IBOutlet weak var buttonZero: CalculatorButton!{
        didSet {
            buttonZero.tag = NumberTag.zero.rawValue
        }
    }
    @IBOutlet weak var buttonDecimal: CalculatorButton!
    
    // Action Buttons
    @IBOutlet weak var buttonAC: CalculatorButton!
    @IBOutlet weak var buttonPlusMinus: CalculatorButton!
    @IBOutlet weak var buttonPercent: CalculatorButton!
    @IBOutlet weak var buttonResult: CalculatorButton!
    @IBOutlet weak var buttonAdd: CalculatorButton!
    @IBOutlet weak var buttonSubtract: CalculatorButton!
    @IBOutlet weak var buttonMultiply: CalculatorButton!
    @IBOutlet weak var buttonDivide: CalculatorButton!
    
    var viewModel = CalculatorViewModel()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonDecimal.setTitle(AppConstants.decimalSeparator, for: .normal)
        viewModel.total = UserDefaults.standard.double(forKey: AppConstants.total)
        calculateResult()
    }
    
    // MARK: -Actions
    @IBAction func ac(_ sender: CalculatorButton) {
        reset()
        sender.glow()
    }
    
    @IBAction func plusMinus(_ sender: CalculatorButton) {
        viewModel.temp = viewModel.temp * (-1)
        resultLabel.text = formatToDisplay.string(from: NSNumber(value: viewModel.temp))
        sender.glow()
    }
    
    @IBAction func percent(_ sender: CalculatorButton) {
        if viewModel.operation != .percent {
            calculateResult()
        }
        viewModel.state = .operating
        viewModel.operation = .percent
        calculateResult()
        sender.glow()
    }
    
    @IBAction func result(_ sender: CalculatorButton) {
        calculateResult()
        sender.glow()
    }
    
    @IBAction func add(_ sender: CalculatorButton) {
        if viewModel.operation != .none {
            calculateResult()
        }
        viewModel.state = .operating
        viewModel.operation = .addiction
        sender.selectOperation(true)
        sender.glow()
    }
    
    @IBAction func subtract(_ sender: CalculatorButton) {
        if viewModel.operation != .none {
            calculateResult()
        }
        viewModel.state = .operating
        viewModel.operation = .subtraction
        sender.selectOperation(true)
        sender.glow()
    }
    
    @IBAction func multiply(_ sender: CalculatorButton) {
        if viewModel.operation != .none {
            calculateResult()
        }
        viewModel.state = .operating
        viewModel.operation = .multiplication
        sender.selectOperation(true)
        sender.glow()
    }
    
    @IBAction func devide(_ sender: CalculatorButton) {
        
        if viewModel.operation != .none {
            calculateResult()
        }
        
        viewModel.state = .operating
        viewModel.operation = .division
        sender.selectOperation(true)
        
        sender.glow()
    }
    
    @IBAction func decimal(_ sender: CalculatorButton) {
        
        let currentTemp = formatToCalculateTotal.string(from: NSNumber(value: viewModel.temp))!
        if resultLabel.text?.contains(AppConstants.decimalSeparator) ?? false || (viewModel.state == .ideal && currentTemp.count >= AppConstants.maxLength) {
            return
        }
        
        resultLabel.text = resultLabel.text! + AppConstants.decimalSeparator
        viewModel.decimal = true
        
        selectVisualOperation()
        
        sender.glow()
    }
    
    @IBAction func numberAction(_ sender: CalculatorButton) {
        
        
        
        buttonAC.setTitle("C", for: .normal)
        
        var currentTemp = formatToCalculateTotal.string(from: NSNumber(value: viewModel.temp))!
      
        if viewModel.state == .ideal && currentTemp.count >= AppConstants.maxLength {
            return
        }
        
        currentTemp = formatToCalculate.string(from: NSNumber(value: viewModel.temp))!
        
        //on operation
        if viewModel.state == .operating {
            viewModel.total = viewModel.total == 0 ? viewModel.temp : viewModel.total
            resultLabel.text = ""
            currentTemp = ""
            viewModel.state = .ideal
        }
        
        // on decimal
        if viewModel.decimal {
            currentTemp = "\(currentTemp)\(AppConstants.decimalSeparator)"
            viewModel.decimal = false
        }
        
        let number = sender.tag
        viewModel.temp = Double(currentTemp + String(number))!
        resultLabel.text = formatToDisplay.string(from: NSNumber(value: viewModel.temp))
        
        selectVisualOperation()
        
        sender.glow()
    }
    
    
    private func reset() {
        viewModel.reset { [unowned self] in
            self.buttonAC.setTitle(viewModel.acButtonText, for: .normal)
            self.resultLabel.text = viewModel.resultText
        }
    }
    

    private func calculateResult() {
        switch viewModel.operation {
        case .addiction:
            viewModel.total = viewModel.total + viewModel.temp
            break
        case .subtraction:
            viewModel.total = viewModel.total - viewModel.temp
            break
        case .multiplication:
            viewModel.total = viewModel.total * viewModel.temp
            break
        case .division:
            viewModel.total = viewModel.total / viewModel.temp
            break
        case .percent:
            viewModel.temp = viewModel.temp / 100
            viewModel.total = viewModel.temp
            break
        case .none:
            break
        }
        
        //formating
        if let currentTotal = formatToCalculateTotal.string(from: NSNumber(value: viewModel.total)), currentTotal.count > AppConstants.maxLength {
            resultLabel.text = formatToDisplayScientific.string(from: NSNumber(value: viewModel.total))
        } else {
            resultLabel.text = formatToDisplay.string(from: NSNumber(value: viewModel.total))
        }
        
        //reset operation
        viewModel.operation = .none
        
        selectVisualOperation()
        UserDefaults.standard.set(viewModel.total, forKey: AppConstants.total)
        
        print("Calculation result is : \(viewModel.total)")
    }
    
    // update UI State
    private func selectVisualOperation() {
        
        switch viewModel.state {
        case .operating:
            switch viewModel.operation {
            case .none, .percent:
                buttonAdd.selectOperation(false)
                buttonSubtract.selectOperation(false)
                buttonMultiply.selectOperation(false)
                buttonDivide.selectOperation(false)
                break
            case .addiction:
                buttonAdd.selectOperation(true)
                buttonSubtract.selectOperation(false)
                buttonMultiply.selectOperation(false)
                buttonDivide.selectOperation(false)
                break
            case .subtraction:
                buttonAdd.selectOperation(false)
                buttonSubtract.selectOperation(true)
                buttonMultiply.selectOperation(false)
                buttonDivide.selectOperation(false)
                break
            case .multiplication:
                buttonAdd.selectOperation(false)
                buttonSubtract.selectOperation(false)
                buttonMultiply.selectOperation(true)
                buttonDivide.selectOperation(false)
                break
            case .division:
                buttonAdd.selectOperation(false)
                buttonSubtract.selectOperation(false)
                buttonMultiply.selectOperation(false)
                buttonDivide.selectOperation(true)
                break
            }
            break
            
        case .ideal:
            buttonAdd.selectOperation(false)
            buttonSubtract.selectOperation(false)
            buttonMultiply.selectOperation(false)
            buttonDivide.selectOperation(false)
            break
        }
    }
    
    
}

