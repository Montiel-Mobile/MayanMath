//
//  UIImage+Mayan.swift
//  MayanMath
//
//  Created by John C Montiel on 1/17/19.
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

import UIKit

public enum SymbolType: String {
    case flat = ""
    case bevel = "Bevel"
}

public enum Symbol: String {
    case one
    case two
    case three
    case four
    case five
    case ten
    case fifteen
    case zero
    case zeroDown
}

let kNegativeColorLiteral = "Red"

extension UIImage {
        
    class func symbol(_ symbol: Symbol, _ type: SymbolType, _ isNegative: Bool) -> UIImage {
        let red = isNegative ? kNegativeColorLiteral : ""
        let name = "\(symbol.rawValue)\(type.rawValue)\(red)"
        return UIImage(named: name,  in: Bundle(for: MayanMath.self), with: nil)!
    }
}
