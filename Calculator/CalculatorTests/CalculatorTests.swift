//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Admin on 26/6/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import Calculator

class CalculatorTests: QuickSpec {

    override func spec() {

        let calculatorVM = CalculatorViewModel()
        
        //mocks
        let two = NumberTag(rawValue: 2)!
        let three = NumberTag(rawValue: 3)!
        let four = NumberTag(rawValue: 4)!
        let six = NumberTag(rawValue: 6)!
        let seven = NumberTag(rawValue: 7)!
        let eight = NumberTag(rawValue: 8)!
        let nine = NumberTag(rawValue: 9)!
        let zero = NumberTag(rawValue: 0)!
        
        describe("adding") {
            
            beforeEach {
                calculatorVM.reset {}
            }
            
            context("2 + 2 ") {
                it("should produce 4") {
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.add {}
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == 4
                }
            }
            
            context("2 + -2 ") {
                it("should produce 0") {
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.add {}
                    calculatorVM.subtract {}
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == 0
                }
            }
            
        }
        
        describe("subtracting") {
            
            beforeEach {
                calculatorVM.reset {}
            }
            
            context("-7 - 2 ") {
                it("should produce -9") {
                    calculatorVM.subtract {}
                    calculatorVM.didPressedNumberWithTag(seven) {}
                    calculatorVM.subtract {}
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == -9
                }
            }
            
            context("2 - 2 ") {
                it("should produce 0") {
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.subtract {}
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == 0
                }
            }
            
        }
        
        
        describe("dividing") {
            context("-9 / 2 ") {
                
                beforeEach {
                    calculatorVM.reset {}
                }
                
                it("should produce -9") {
                    calculatorVM.subtract {}
                    calculatorVM.didPressedNumberWithTag(nine) {}
                    calculatorVM.devide {}
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == -4.5
                }
            }
            
            context("2 / 0 ") {
                
                beforeEach {
                    calculatorVM.reset {}
                }
                
                it("should produce infinity") {
                    calculatorVM.didPressedNumberWithTag(two) {}
                    calculatorVM.devide {}
                    calculatorVM.didPressedNumberWithTag(zero) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == Double.infinity
                }
            }
            
        }
        
        
        describe("multiply") {
            context("8 * 6") {
                
                beforeEach {
                    calculatorVM.reset {}
                }
                
                it("should produce 48") {
                    calculatorVM.didPressedNumberWithTag(eight) {}
                    calculatorVM.multiply {}
                    calculatorVM.didPressedNumberWithTag(six) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == 48
                }
            }
            
            context("3 * 4 ") {
                
                beforeEach {
                    calculatorVM.reset {}
                }
                
                it("should produce 12") {
                    calculatorVM.didPressedNumberWithTag(three) {}
                    calculatorVM.multiply {}
                    calculatorVM.didPressedNumberWithTag(four) {}
                    calculatorVM.calculate {}
                    expect(calculatorVM.result) == 12
                }
            }
            
        }
        
        
    }

}
