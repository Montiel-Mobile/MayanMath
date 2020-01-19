//
//  MayanMath.swift
//  MayanCalc
//
//  Created by John C Montiel on 1/18/20.
//  Copyright © 2020 Black Pixel. All rights reserved.
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
    
    public static let shared = MayanMath()
    
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

    // First operand
    public var firstSymbols: [Int] = []
    public var firstInt: Int? {
        return _firstInt
    }
    private var _firstInt: Int? = nil

    // Second operand
    public var secondInt: Int? {
        return _secondInt
    }
    private var _secondInt: Int? = nil
    public var secondSymbols: [Int] = []

    // Result
    public var resultSymbols: [Int] {
        return _resultSymbols
    }
    private var _resultSymbols: [Int] = []

    public var resultsInt: Int? {
        return _resultsInt
    }
    private var _resultsInt: Int? = nil

    public var resultsRem: Int? {
        return _resultsRem
    }
    private var _resultsRem: Int? = nil
    
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

    // Math Operators
    public var mathOp: mathOperation? = nil
    public var equalEnabled: Bool = false

    // Used when converting digital -> Mayan
    public func setFirst(_ int: Int) {
        _firstInt = int
        firstSymbols = int.digitValues()
        resetLast()
    }
    
    public func resetInts(startWithResult: Bool = false) {
        
        _firstInt = startWithResult ? resultsInt : nil
        firstSymbols = startWithResult ? resultSymbols : []
        resetLast()
    }

    public func resetLast() {
        
        _secondInt = nil
        _resultsInt = nil
        _resultsRem = nil
        mathOp = nil
        secondSymbols =  []
        _resultSymbols = []
        equalEnabled = false
    }

    public func deriveInts() {

        var factor: Int = 1
        _firstInt = 0
        
        for int in firstSymbols.reversed() {
            _firstInt! += int * factor
            factor *= 20
        }
        
        factor = 1
        _secondInt = nil
        if secondSymbols.count > 0 {
            
            _secondInt = 0
            
            for int in secondSymbols.reversed() {
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
    
    public func calculateResults() {
        
        _resultSymbols = []

        guard equalEnabled == true, let mathOp = mathOp, let first = firstInt, let second = secondInt else { return }
        
        switch mathOp {
        case .add:
            _resultSymbols = (first + second).digitValues()
            
        case .subtract:
            _resultSymbols = (first - second).digitValues()
            
        case .multiply:
            _resultSymbols = (first * second).digitValues()

        case .divide:
            _resultSymbols = (first / second).digitValues()
        }
    }
}
