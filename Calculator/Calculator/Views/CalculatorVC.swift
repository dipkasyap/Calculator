//
//  CalculatorVC.swift
//  Calculator
//
//  Created by Devi Prasad Ghimire on 26/6/20.
//  Copyright © 2020 Devi Prasad Ghimire. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    
    @IBOutlet var operatorButtons: [CalculatorOperatorButton]!
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
    
}

//MARK:- UI Setup
extension CalculatorVC {
    
    private func setupUI() {
        buttonDecimal.setTitle(AppConstants.decimalSeparator, for: .normal)
        view.backgroundColor = AppConstants.Color.eerieBlack
    }
    func commonUpdateOnUI() {
        self.buttonAC.setTitle(viewModel.acButtonText, for: .normal)
        self.resultLabel.text = viewModel.resultText
    }
    
    private func updateOperatorButtonsAppearance() {
        
        operatorButtons.forEach{$0.activate(false)}
        
        switch viewModel.state {
        case .operating:
            switch viewModel.operation {
            case .addition:
                buttonAdd.activate(true)
                break
            case .subtraction:
                buttonSubtract.activate(true)
                break
            case .multiplication:
                buttonMultiply.activate(true)
                break
            case .division:
                buttonDivide.activate(true)
                break
            default:
                break
            }
            break
            
        case .ideal:
            operatorButtons.forEach{$0.activate(false)}
            break
        }
    }
}

// MARK: -Actions
extension CalculatorVC {
    @IBAction func didTapAC(_ button: CalculatorButton) {
        viewModel.reset { [unowned self] in
            self.commonUpdateOnUI()
            self.updateOperatorButtonsAppearance()
        }
    }
    
    @IBAction func didTapPlusMinus(_ button: CalculatorButton) {
        viewModel.plusMinus { [unowned self] in
            self.commonUpdateOnUI()
        }
    }
    
    @IBAction func didTapPercent(_ button: CalculatorButton) {
        viewModel.percent { [unowned self] in
            self.commonUpdateOnUI()
        }
    }
    
    @IBAction func didTapResult(_ button: CalculatorOperatorButton) {
        viewModel.calculate {
            self.commonUpdateOnUI()
        }
    }
    
    @IBAction func didTapAdd(_ button: CalculatorOperatorButton) {
        viewModel.add { [unowned self] in
            self.commonUpdateOnUI()
        }
        //button.activate(true)
    }
    
    @IBAction func didTapSubtract(_ button: CalculatorOperatorButton) {
        viewModel.subtract { [unowned self] in
            self.commonUpdateOnUI()
        }
        //button.activate(true)
    }
    
    @IBAction func didTapMultiply(_ button: CalculatorOperatorButton) {
        viewModel.multiply { [unowned self] in
            self.commonUpdateOnUI()
        }
        //button.activate(true)
    }
    
    @IBAction func didTapDivide(_ button: CalculatorOperatorButton) {
        viewModel.devide { [unowned self] in
            self.commonUpdateOnUI()
        }
        //button.activate(true)
    }
    
    @IBAction func didTapDecimal(button: CalculatorButton) {
        viewModel.decimal { [unowned self] in
            self.commonUpdateOnUI()
            self.updateOperatorButtonsAppearance()
        }
    }
    
    @IBAction func didTapNumber(_ button: CalculatorOperandButton) {
        guard let tag = NumberTag(rawValue: button.tag) else {fatalError("Number button should have associated tag to identify number")}
        viewModel.didPressedNumberWithTag(tag) { [unowned self] in
            self.commonUpdateOnUI()
            self.updateOperatorButtonsAppearance()
        }
    }
}

