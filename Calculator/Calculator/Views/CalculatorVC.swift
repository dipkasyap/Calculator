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
    @IBOutlet weak var buttonOne: CalculatorOperandButton! {
        didSet {
            buttonOne.tag = NumberTag.one.rawValue
        }
    }
    @IBOutlet weak var buttonTwo: CalculatorOperandButton!{
        didSet {
            buttonTwo.tag = NumberTag.two.rawValue
        }
    }
    @IBOutlet weak var buttonThree: CalculatorOperandButton!{
        didSet {
            buttonThree.tag = NumberTag.three.rawValue
        }
    }
    @IBOutlet weak var buttonFour: CalculatorOperandButton!{
        didSet {
            buttonFour.tag = NumberTag.four.rawValue
        }
    }
    @IBOutlet weak var buttonFive: CalculatorOperandButton!{
        didSet {
            buttonFive.tag = NumberTag.five.rawValue
        }
    }
    @IBOutlet weak var buttonSix: CalculatorOperandButton!{
        didSet {
            buttonSix.tag = NumberTag.six.rawValue
        }
    }
    @IBOutlet weak var buttonSeven: CalculatorOperandButton!{
        didSet {
            buttonSeven.tag = NumberTag.seven.rawValue
        }
    }
    @IBOutlet weak var buttonEight: CalculatorOperandButton!{
        didSet {
            buttonEight.tag = NumberTag.eight.rawValue
        }
    }
    @IBOutlet weak var buttonNine: CalculatorOperandButton!{
        didSet {
            buttonNine.tag = NumberTag.nine.rawValue
        }
    }
    @IBOutlet weak var buttonZero: CalculatorOperandButton!{
        didSet {
            buttonZero.tag = NumberTag.zero.rawValue
        }
    }
    @IBOutlet weak var buttonDecimal: CalculatorButton!
    
    // Action Buttons
    @IBOutlet weak var buttonAC: CalculatorButton!
    @IBOutlet weak var buttonPlusMinus: CalculatorButton!
    @IBOutlet weak var buttonPercent: CalculatorButton!
    @IBOutlet weak var buttonResult: CalculatorOperatorButton!
    @IBOutlet weak var buttonAdd: CalculatorOperatorButton!
    @IBOutlet weak var buttonSubtract: CalculatorOperatorButton!
    @IBOutlet weak var buttonMultiply: CalculatorOperatorButton!
    @IBOutlet weak var buttonDivide: CalculatorOperatorButton!
    
    var viewModel = CalculatorViewModel()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- UI Setup
    private func setupUI() {
        buttonDecimal.setTitle(AppConstants.decimalSeparator, for: .normal)
        view.backgroundColor = AppConstants.Color.eerieBlack
    }
    
    // MARK: -Actions
    @IBAction func ac(_ sender: CalculatorButton) {
        reset()
    }
    
    @IBAction func plusMinus(_ sender: CalculatorButton) {
        viewModel.plusMinus { [unowned self] in
            self.commonUpdateOnUI()
        }
    }
    
    @IBAction func percent(_ sender: CalculatorButton) {
        viewModel.percent { [unowned self] in
            self.commonUpdateOnUI()
        }
    }
    
    @IBAction func result(_ sender: CalculatorButton) {
        viewModel.calculate {
            self.commonUpdateOnUI()
        }
    }
    
    @IBAction func add(_ sender: CalculatorButton) {
        viewModel.add { [unowned self] in
            self.commonUpdateOnUI()
        }
        sender.activate(true)
    }
    
    @IBAction func subtract(_ sender: CalculatorButton) {
        viewModel.subtract { [unowned self] in
            self.commonUpdateOnUI()
        }
        sender.activate(true)
    }
    
    @IBAction func multiply(_ sender: CalculatorButton) {
        viewModel.multiply { [unowned self] in
            self.commonUpdateOnUI()
        }
        sender.activate(true)
    }
    
    @IBAction func devide(_ sender: CalculatorButton) {
        viewModel.devide { [unowned self] in
            self.commonUpdateOnUI()
        }
        sender.activate(true)
    }
    
    @IBAction func decimal(_ sender: CalculatorButton) {
        
        viewModel.decimal { [unowned self] in
            self.commonUpdateOnUI()
            self.updateOperatorButtonsAppearance()
        }
        
        
//        let currentTemp = formatToCalculateTotal.string(from: NSNumber(value: viewModel.temp))!
//        if resultLabel.text?.contains(AppConstants.decimalSeparator) ?? false || (viewModel.state == .ideal && currentTemp.count >= AppConstants.maxLength) {
//            return
//        }
//
//        resultLabel.text = resultLabel.text! + AppConstants.decimalSeparator
//        viewModel.decimal = true
//
//        updateOperatorButtonsAppearance()
        
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
            viewModel.result = viewModel.result == 0 ? viewModel.temp : viewModel.result
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
        
        updateOperatorButtonsAppearance()
        
    }
    
    
    private func reset() {
        viewModel.reset { [unowned self] in
            self.commonUpdateOnUI()
        }
    }
    
    
    func commonUpdateOnUI() {
        self.buttonAC.setTitle(viewModel.acButtonText, for: .normal)
        self.resultLabel.text = viewModel.resultText
    }
    
    
    private func calculateResult() {
        switch viewModel.operation {
        case .addiction:
            viewModel.result = viewModel.result + viewModel.temp
            break
        case .subtraction:
            viewModel.result = viewModel.result - viewModel.temp
            break
        case .multiplication:
            viewModel.result = viewModel.result * viewModel.temp
            break
        case .division:
            viewModel.result = viewModel.result / viewModel.temp
            break
        case .percent:
            viewModel.temp = viewModel.temp / 100
            viewModel.result = viewModel.temp
            break
        case .none:
            break
        }
        
        //formating
        if let currentTotal = formatToCalculateTotal.string(from: NSNumber(value: viewModel.result)), currentTotal.count > AppConstants.maxLength {
            resultLabel.text = formatToDisplayScientific.string(from: NSNumber(value: viewModel.result))
        } else {
            resultLabel.text = formatToDisplay.string(from: NSNumber(value: viewModel.result))
        }
        
        //reset operation
        viewModel.operation = .none
        
        updateOperatorButtonsAppearance()
        
        print("Calculation result is : \(viewModel.result)")
    }
    
    // update UI State
    private func updateOperatorButtonsAppearance() {
        
        switch viewModel.state {
        case .operating:
            switch viewModel.operation {
            case .none, .percent:
                buttonAdd.activate(false)
                buttonSubtract.activate(false)
                buttonMultiply.activate(false)
                buttonDivide.activate(false)
                break
            case .addiction:
                buttonAdd.activate(true)
                buttonSubtract.activate(false)
                buttonMultiply.activate(false)
                buttonDivide.activate(false)
                break
            case .subtraction:
                buttonAdd.activate(false)
                buttonSubtract.activate(true)
                buttonMultiply.activate(false)
                buttonDivide.activate(false)
                break
            case .multiplication:
                buttonAdd.activate(false)
                buttonSubtract.activate(false)
                buttonMultiply.activate(true)
                buttonDivide.activate(false)
                break
            case .division:
                buttonAdd.activate(false)
                buttonSubtract.activate(false)
                buttonMultiply.activate(false)
                buttonDivide.activate(true)
                break
            }
            break
            
        case .ideal:
            buttonAdd.activate(false)
            buttonSubtract.activate(false)
            buttonMultiply.activate(false)
            buttonDivide.activate(false)
            break
        }
    }
    
    
}

