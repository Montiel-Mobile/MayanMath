//
//  Int+Mayan.swift
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

import Foundation
import UIKit

public extension Int {
    
    func digitValues(forBase base: Int = 20) -> [Int] {
        
        var ints: [Int] = []
        var isNegative: Bool {
            return self < 0
        }
        var value = self
        
        if value == 0 {
            ints.append(0)
        }
        else {
            
            value *= isNegative ? -1 : 1

            while value > 0 {
                ints.insert((value % base) * (isNegative ? -1 : 1), at: 0)
                value /= base
            }
        }
        return ints
    }
    
    func mayanSymbols(_ symbolType: SymbolType) -> [[UIImage]] {

        var symbols: [[UIImage]] = []
        var isNegative: Bool {
            return self < 0
        }
        var value = self
        
        if value == 0 {
            symbols.append([.symbol(Symbol.zeroDown, symbolType, isNegative)])
        }
        else {
            
            value *= isNegative ? -1 : 1
            
            while value > 0 {
                
                var remainder20 = value % 20
                var symbol: [UIImage] = []
                
                if  remainder20 > 4 {
                    let remainder5 = remainder20 % 5
                    switch remainder5 {
                    case 1:
                        symbol.append(.symbol(Symbol.one, symbolType, isNegative))
                    case 2:
                        symbol.append(.symbol(Symbol.two, symbolType, isNegative))
                    case 3:
                        symbol.append(.symbol(Symbol.three, symbolType, isNegative))
                    case 4:
                        symbol.append(.symbol(Symbol.four, symbolType, isNegative))
                    default:
                        break
                    }
                    
                    remainder20 /= 5
                    switch remainder20 {
                    case 0:
                        symbol.append(.symbol(Symbol.zeroDown, symbolType, isNegative))
                    case 1:
                        symbol.append(.symbol(Symbol.five, symbolType, isNegative))
                    case 2:
                        symbol.append(.symbol(Symbol.ten, symbolType, isNegative))
                    case 3:
                        symbol.append(.symbol(Symbol.fifteen, symbolType, isNegative))
                    default:
                        break
                    }
                }
                else {
                    switch remainder20 {
                    case 0:
                        symbol.append(.symbol(Symbol.zeroDown, symbolType, isNegative))
                    case 1:
                        symbol.append(.symbol(Symbol.one, symbolType, isNegative))
                    case 2:
                        symbol.append(.symbol(Symbol.two, symbolType, isNegative))
                    case 3:
                        symbol.append(.symbol(Symbol.three, symbolType, isNegative))
                    case 4:
                        symbol.append(.symbol(Symbol.four, symbolType, isNegative))
                    default:
                        break
                    }
                    remainder20 = 0
                }

                value /= 20
                symbols.insert(symbol, at: 0)
            }
        }

        return symbols
    }
}
