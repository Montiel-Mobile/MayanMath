//
//  MayanMath.swift
//  MayanMath
//
//  Created by John C Montiel on 1/18/20.
//
//    Copyright (C) 2019-2020 by Montiel Mobile, LLC
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.


import Foundation
import UIKit

public enum MathOperation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "X"
    case divide = "/"
}

public typealias MayanGlyph = (int: Int, glyph: UIImage)

/**
   A Swift class for Xcode iOS apps that provides Mayan Number Glyph mathematical operations
  
   This class enables:
    - Conversion from integer to base 20 integer places and Mayan glyphs images
    - Math operations on base 20 integer places array operands and results. The consumer populates the base 20 integer places arrays, using the various methods available.
  
 * Author: John Montiel, Montiel Mobile, LLC
 * Version: 1.4
 */
public class MayanMath: ObservableObject {
    /**
      Reference to the shared singleton instance of MayanMath
    */
    public static let shared = MayanMath()
    
    /**
      Given an Int between 0 and 19, inclusively, returns a MayanGlyph
     
      If an integer greater than 19 is passed, only the Mayan glyph of the last position is returned.
    * Parameter int: An integer.
    * Returns: a MayanGlyph.
    */
    public class func mayanGlyph(forInt int: Int, _ symbolType: SymbolType = .flat) -> MayanGlyph {
        
        guard let glyph = MayanMath.symbols(forInt: int, symbolType).last else {
            fatalError("Something is wrong, should always derive a symbol")
        }
        
        return (int, glyph)
    }

    /**
      Given an Int returns the Mayan glyph images
     
      The glyphs are an array of UIImage.
    * Parameter int: An integer.
    * Returns: an array of UIImage.
    */
    public class func symbols(forInt int: Int, _ symbolType: SymbolType) -> [UIImage] {
        
        var mayanSymbols: [UIImage] = []
        for symbol in int.mayanSymbols(symbolType) {
            if let mayanSymbol  = MayanMath.image(forMayanSymbols: symbol) {
                mayanSymbols.append(mayanSymbol)
            }
        }
        return mayanSymbols
    }
    
    /**
      Given an Int returns the Mayan glyph images
     
      The glyphs are an array of UIImage.
    * Parameter symbols: An array of one or two Image that represent a combined dot and bar glyph.
    * Returns: a UIImage.
    */
    private class func image(forMayanSymbols symbols: [UIImage]) -> UIImage? {
        
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
      Left side operand in math operation or integer being converted
    */
    public var leftSide: Int? {
        return _leftSide
    }
    private var _leftSide: Int? = nil
    
    /**
      Left side operand base 20 places representation
     
      Append with the base 20 place values of an integer, where the last item is the 1's place, second to last is the 20's place, third to last is the 400's place, etc., as the user selects Mayan glyphs
    */
    @Published public var leftSideDigitValues: [Int] = []

    /**
      Right side operand in math operation
    */
    public var rightSide: Int? {
        return _rightSide
    }
    private var _rightSide: Int? = nil
    
    /**
      Right side operand base 20 places representation
     
      Append with the base 20 place values of an integer, where the last item is the 1's place, second to last is the 20's place, third to last is the 400's place, etc., as the user selects Mayan glyphs
    */
    @Published public var rightSideDigitValues: [Int] = []

    /**
      Result of math operation
    */
    public var resultsInt: Int? {
        return _resultsInt
    }
    private var _resultsInt: Int? = nil

    /**
      Result base 20 places representation
     
      Use MayanMath.mayanGlyph(forInt:).last for each Int in the array of places for the MayanGlyph, which contains the int: Int and glyph: UIImage values
    */
    @Published public var resultDigitValues: [Int] = []


    /**
      Result string representation.
     
      A string showing the left and right side operands, math operation and result
    */
    public var resultsString: String {
        
        if resultsInt ?? 0 == Int.max {
            return "Invalid operation"
        }
        else if mathOp == nil {
            return "\(leftSide ?? 0)"
        }
        else if equalEnabled == true {
            return "\(leftSide ?? 0) \(mathOp?.rawValue ?? "") \(rightSide ?? 0) = \((resultsInt ?? 0)) \(resultsRem == nil ? "" : "~[\(resultsRem!)]")"
        }
        else {
            return "\(leftSide ?? 0) \(mathOp?.rawValue ?? "") \(rightSide ?? 0)"
        }
    }

    /**
      Integer remainder of math operation
    */
    public var resultsRem: Int? {
        return _resultsRem
    }
    private var _resultsRem: Int? = nil
    
    /**
      Math operator enumeration.
     
      Should be set when the left side operand is fixed
      - Valid values are .add, .subtract, .multiply and .divide
    */
    @Published public var mathOp: MathOperation? = nil
    
    
    /**
      Should be set to true to when the left and right side operands are fixed
    */
    @Published public var equalEnabled: Bool = false

    /**
      Set the left side operand or integer (Int) to be converted to Mayan Glyphs
     
      This is normally used for decimal to Mayan Glyph conversions
    * Parameter int: An integer.
    */
    public func reset(withInt int: Int) {
        _leftSide = int
        leftSideDigitValues = int.digitValues()
        resetRightSide()
    }
    
    /**
      Reset math operands and operators
     
      Clears the operands and operators. When startWithResult is true, sets the current result to the left side operand
    * Parameter startWithResult: Set to true to make the current result the subsequent left side operand. Default is false.
    */
    public func reset(startWithResult: Bool = false) {
        
        _leftSide = startWithResult ? resultsInt : nil
        leftSideDigitValues = startWithResult ? resultDigitValues : []
        resetRightSide()
    }

    /**
      Clears the right side math operand and operators
    */
    public func resetRightSide() {
        
        _rightSide = nil
        _resultsInt = nil
        _resultsRem = nil
        mathOp = nil
        rightSideDigitValues =  []
        resultDigitValues = []
        equalEnabled = false
    }
    
    private let maxFactor = Int.max / 8000 // Factored by three orders of magnitude (base 20) less than max
    private let exceedeMaxError = NSError(domain: "MayanMath", code: 999, userInfo: [NSLocalizedDescriptionKey: "Integer value exceeded capacity"])
    private let divisionError = NSError(domain: "MayanMath", code: 998, userInfo: [NSLocalizedDescriptionKey: "Division by zero"])

    /**
      Derive the results
     
      Populate the operand and result integer values, and result array of base 20 places from the operand base 20 places values and math operation.
     
      Use MayanMath.mayanGlyph(forInt:).last for each Int in the array of places for the MayanGlyph, which contains the int: Int and glyph: UIImage values
    */
    public func deriveResults() {
        
        do {
            var factor: Int = 1
            _leftSide = 0
            
            for int in leftSideDigitValues.reversed() {
                if factor > maxFactor { throw exceedeMaxError }
                
                _leftSide! += int * factor
                factor *= 20
            }
            
            factor = 1
            _rightSide = nil
            if rightSideDigitValues.count > 0 {
                _rightSide = 0
                
                for int in rightSideDigitValues.reversed() {
                    if factor > maxFactor { throw exceedeMaxError }

                    _rightSide! += int * factor
                    factor *= 20
                }
            }
            
            _resultsInt = nil
            _resultsRem = nil
            if  equalEnabled == true, let mathOp = mathOp, let first = leftSide, let second = rightSide {
                switch mathOp {
                case .add:
                    _resultsInt = first + second
                    
                case .subtract:
                    _resultsInt = first - second
                    
                case .multiply:
                    _resultsInt = first * second
                    
                case .divide:
                    if second > 0 {
                        _resultsRem = first % second > 0 ? first % second : nil
                        _resultsInt = first / second
                    }
                    else {
                        throw divisionError
                    }
                }
            }
        }
        catch(_) {
            _resultsRem = 0
            _resultsInt = Int.max
            resultDigitValues = []
            return
        }
        
        resultDigitValues = []
        guard equalEnabled == true, let result = resultsInt else { return }
        resultDigitValues = result.digitValues()
    }    
}
