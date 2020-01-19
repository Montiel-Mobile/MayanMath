//
//  MayanMath.swift
//  MayanCalc
//
//  Created by John C Montiel on 1/18/20.
//  Copyright © 2020 Montiel Mobile, LLC. All rights reserved.
//

import Foundation
import UIKit

public enum mathOperation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"
}


public class MayanMath {
    /**
    * Reference to the shared singleton instance of MayanMath
    *
    * @discussion Reference to the shared singleton instance of MayanMath
    *
    * @return Reference to the shared singleton instance of MayanMath.
    */
    public static let shared = MayanMath()
    
    /**
    * Given an Int returns an array of Mayan number glyphs
    *
    * @discussion Given an Int returns an array of UIImages with the Mayan Glyph representation with a transparent background.
    *
    * @param forInt An integer.
    * @return an array of Mayan number glyphs.
    */
    public class func symbols(forInt int: Int) -> [UIImage] {
        
        var mayanSymbols: [UIImage] = []
        for symbol in int.mayanSymbols() {
            if let mayanSymbol  = MayanMath.image(mayanSymbol: symbol) {
                mayanSymbols.append(mayanSymbol)
            }
        }
        return mayanSymbols
    }
    
    private class func image(mayanSymbol symbols: [UIImage]) -> UIImage? {
        
        if  symbols.count == 1 {
            return MayanMath.image(mayanTop: nil, mayanBottom: symbols[0])
        }
        else if symbols.count == 2 {
            return MayanMath.image(mayanTop: symbols[0], mayanBottom: symbols[1])
        }
        else {
            return nil
        }
    }
    
    private class func image(mayanTop topImage: UIImage? = nil, mayanBottom bottomImage: UIImage) -> UIImage? {
        
        var newSymbolImage: UIImage? = nil

        var bottomRect: CGRect = CGRect(x: 0, y: (bottomImage.size.width - bottomImage.size.height) / 2, width: bottomImage.size.width, height: bottomImage.size.height)

        if  let bottomCGImage = bottomImage.cgImage {
            
            var topCGImage: CGImage? = nil
            var topRect: CGRect? = nil
            
            if  let topImage = topImage, let top = topImage.cgImage {
                
                topCGImage = top
                topRect = CGRect(x: 0, y: (bottomImage.size.width - (bottomImage.size.height + topImage.size.height)) / 2, width: bottomImage.size.width, height: topImage.size.height)
                
                bottomRect = CGRect(x: 0, y: topRect!.origin.y + topRect!.size.height, width: bottomImage.size.width, height: bottomImage.size.height)
            }
            
            UIGraphicsBeginImageContext(CGSize(width: bottomImage.size.width, height: bottomImage.size.width))
            let context = UIGraphicsGetCurrentContext()!
            context.interpolationQuality = .none
            
            if  let topCGImage = topCGImage, let topRect = topRect {
                context.draw(topCGImage, in: topRect)
            }
            context.draw(bottomCGImage, in: bottomRect)
            
            if let preImage = UIGraphicsGetImageFromCurrentImageContext(), let cgImage = preImage.cgImage {
                newSymbolImage = UIImage(cgImage: cgImage, scale: 1.0/UIScreen.main.scale, orientation: .upMirrored)
            }
            UIGraphicsEndImageContext()
        }
        
        return newSymbolImage
    }

    /**
    * Left side operand in math operation or integer being converted
    */
    public var firstInt: Int? {
        return _firstInt
    }
    private var _firstInt: Int? = nil
    
    /**
    * Left side operand base 20 digits representation
    */
    public var firstDigitValues: [Int] = []

    /**
    * Right side operand in math operation
    */
    public var secondInt: Int? {
        return _secondInt
    }
    private var _secondInt: Int? = nil
    
    /**
    * Right side operand base 20 digits representation
    */
    public var secondDigitValues: [Int] = []

    /**
    * Result of math operation
    */
    public var resultsInt: Int? {
        return _resultsInt
    }

    /**
    * Result base 20 digits representation
    */
    public var resultDigitValues: [Int] {
        return _resultDigitValues
    }
    private var _resultDigitValues: [Int] = []

    private var _resultsInt: Int? = nil

    /**
    * Result string representation
    */
    public var resultsString: String {
        
        if mathOp == nil {
            return "\(firstInt ?? 0)"
        }
        else if equalEnabled == true {
            return "\(firstInt ?? 0) \(mathOp?.rawValue ?? "") \(secondInt ?? 0) = \((resultsInt ?? 0)) \(resultsRem == nil ? "" : "~[\(MayanMath.shared.resultsRem!)]")"
        }
        else {
            return "\(firstInt ?? 0) \(mathOp?.rawValue ?? "") \(secondInt ?? 0)"
        }
    }

    /**
    * Remainder of math operation
    */
    public var resultsRem: Int? {
        return _resultsRem
    }
    private var _resultsRem: Int? = nil
    
    /**
    * Math operator
    */
    public var mathOp: mathOperation? = nil
    
    
    /**
    * Should be set to true when the two operands have been set and is ready for calculation
    */
    public var equalEnabled: Bool = false

    /**
    * Set the left side operand or integer (Int) to be converted to Mayan Glyphs
    *
    * @discussion This is normally used for decimal to Mayan Glyph conversions
    *
    * @param int An integer.
    */
    public func setFirst(_ int: Int) {
        _firstInt = int
        firstDigitValues = int.digitValues()
        resetLast()
    }
    
    /**
    * Reset math operands and operators
    *
    * @discussion Clears the operands and operators. When startWithResult is true, sets the current result to the left side operand
    *
    * @param startWithResult Default is false. Pass true to make the current result the subsequent left side operand.
    */
    public func resetInts(startWithResult: Bool = false) {
        
        _firstInt = startWithResult ? resultsInt : nil
        firstDigitValues = startWithResult ? resultDigitValues : []
        resetLast()
    }

    /**
    * Reset right side math operand and operators
    *
    * @discussion Clears the right side math operand and operators.
    */
    public func resetLast() {
        
        _secondInt = nil
        _resultsInt = nil
        _resultsRem = nil
        mathOp = nil
        secondDigitValues =  []
        _resultDigitValues = []
        equalEnabled = false
    }

    /**
    * Derive the operand integer values from the math operation and array of digit values
    *
    * @discussion Derive the operand integer values from the math operation and array of digit values.
    */
    public func deriveInts() {

        var factor: Int = 1
        _firstInt = 0
        
        for int in firstDigitValues.reversed() {
            _firstInt! += int * factor
            factor *= 20
        }
        
        factor = 1
        _secondInt = nil
        if secondDigitValues.count > 0 {
            
            _secondInt = 0
            
            for int in secondDigitValues.reversed() {
                _secondInt! += int * factor
                factor *= 20
            }
        }
        
        _resultsInt = nil
        _resultsRem = nil
        if  equalEnabled == true, let mathOp = mathOp, let first = firstInt, let second = secondInt {
            switch mathOp {
            case .add:
                _resultsInt = first + second
                
            case .subtract:
                _resultsRem = first >= second ? nil : first - second
                _resultsInt = first >= second ? first - second : 0
                
            case .multiply:
                _resultsInt = first * second
                
            case .divide:
                _resultsRem = first % second > 0 ? first % second : nil
                _resultsInt = first / second
            }
        }
    }
    
    /**
    * Derive the  array of digit values from the math operation and operand integer values
    *
    * @discussion Derive the  array of digit values from the math operation and operand integer values.
    */
    public func calculateResults() {
        
        _resultDigitValues = []

        guard equalEnabled == true, let mathOp = mathOp, let first = firstInt, let second = secondInt else { return }
        
        switch mathOp {
        case .add:
            _resultDigitValues = (first + second).digitValues()
            
        case .subtract:
            _resultDigitValues = (first - second).digitValues()
            
        case .multiply:
            _resultDigitValues = (first * second).digitValues()

        case .divide:
            _resultDigitValues = (first / second).digitValues()
        }
    }
}
