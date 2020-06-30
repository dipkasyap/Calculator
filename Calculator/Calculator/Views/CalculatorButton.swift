//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Admin on 29/6/20.
//  Copyright © 2020 Devi Prasad Ghimire. All rights reserved.
//

import UIKit

open class CalculatorOperandButton: CalculatorButton {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        colorSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        colorSetup()
    }
    
    private func colorSetup() {
        backgroundColor = AppConstants.Color.darkLiver
        setTitleColor(AppConstants.Color.white, for: .normal)
    }
    
}


open class CalculatorOperatorButton: CalculatorButton {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        colorSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        colorSetup()
    }
    
    private func colorSetup() {
        backgroundColor = AppConstants.Color.vividGamboge
        setTitleColor(AppConstants.Color.white, for: .normal)
    }
    
}


open class CalculatorButton: UIButton {
    
    @IBInspectable open var roundCorner: CGFloat = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK: - Animations
    @IBInspectable open var animatedScaleWhenHighlighted: CGFloat = 0.9
    @IBInspectable open var animatedScaleDurationWhenHightLighted: Double = 0.2
    @IBInspectable open var animatedScaleWhenSelected: CGFloat = 1.0
    @IBInspectable open var animatedScaleDurationWhenSelected: Double = 0.2
    
    
    //MARK:-  setup
   required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        colorSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        colorSetup()
    }
    
    private func colorSetup() {
        backgroundColor = AppConstants.Color.lightGray
        setTitleColor(AppConstants.Color.eerieBlack, for: .normal)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = roundCorner
        layer.masksToBounds = true
    }
    
    override open var isHighlighted: Bool {
        didSet {
            guard animatedScaleWhenHighlighted != 1.0 else {
                return
            }
            
            if isHighlighted{
                UIView.animate(withDuration: animatedScaleDurationWhenHightLighted, animations: {
                    self.transform = CGAffineTransform(scaleX: self.animatedScaleWhenHighlighted, y: self.animatedScaleWhenHighlighted)
                })
            }
            else{
                UIView.animate(withDuration: animatedScaleDurationWhenHightLighted, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    override open var isSelected: Bool{
        didSet {
            guard animatedScaleWhenSelected != 1.0 else {
                return
            }
            
            UIView.animate(withDuration: animatedScaleDurationWhenSelected, animations: {
                self.transform = CGAffineTransform(scaleX: self.animatedScaleWhenSelected, y: self.animatedScaleWhenSelected)
            }) { (finished) in
                UIView.animate(withDuration: self.animatedScaleDurationWhenSelected, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    //MARK: - Actions
    func activate(_ active: Bool) {
        backgroundColor = active ? AppConstants.Color.white : AppConstants.Color.vividGamboge
        setTitleColor(active ? AppConstants.Color.vividGamboge : AppConstants.Color.white, for: .normal)
    }
    
    private var tapAction: (() -> Void)?
    
    open func touchUpInside(action: (() -> Void)? = nil){
        self.tapAction = action
    }
    
    @objc func tapped(sender: CalculatorButton) {
        self.tapAction?()
    }
    
    //MARK: - Interface Builder Methods
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    override open func prepareForInterfaceBuilder() {}
}
