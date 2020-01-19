//
//  Int+Mayan.swift
//  MayanCalc
//
//  Created by John C Montiel on 1/17/19.
//  Copyright © 2019 Black Pixel. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    func digitValues(forBase base: Int = 20) -> [Int] {
        
        var ints: [Int] = []
        var value = self
        if value > 0 {
            while value > 0 {
                ints.insert(value % base, at: 0)
                value /= base
            }
        }
        else {
            ints.append(0)
        }
        return ints
    }
    
    func mayanSymbols() -> [[UIImage]] {

        var symbols: [[UIImage]] = []
        
        var value = self
        
        if value > 0 {
            
            while value > 0 {
                
                var remainder20 = value % 20
                var symbol: [UIImage] = []
                
                if  remainder20 > 4 {
                    let remainder5 = remainder20 % 5
                    switch remainder5 {
                    case 1:
                        symbol.append(#imageLiteral(resourceName: "one"))
                    case 2:
                        symbol.append(#imageLiteral(resourceName: "two"))
                    case 3:
                        symbol.append(#imageLiteral(resourceName: "three"))
                    case 4:
                        symbol.append(#imageLiteral(resourceName: "four"))
                    default:
                        break
                    }
                    
                    remainder20 /= 5
                    switch remainder20 {
                    case 0:
                        symbol.append(#imageLiteral(resourceName: "zeroDown"))
                    case 1:
                        symbol.append(#imageLiteral(resourceName: "five"))
                    case 2:
                        symbol.append(#imageLiteral(resourceName: "ten"))
                    case 3:
                        symbol.append(#imageLiteral(resourceName: "fifteen"))
                    case 4:
                        symbol.append(#imageLiteral(resourceName: "five"))
                        symbol.append(#imageLiteral(resourceName: "zero"))
                    default:
                        break
                    }
                }
                else {
                    switch remainder20 {
                    case 0:
                        symbol.append(#imageLiteral(resourceName: "zeroDown"))
                    case 1:
                        symbol.append(#imageLiteral(resourceName: "one"))
                    case 2:
                        symbol.append(#imageLiteral(resourceName: "two"))
                    case 3:
                        symbol.append(#imageLiteral(resourceName: "three"))
                    case 4:
                        symbol.append(#imageLiteral(resourceName: "four"))
                    default:
                        break
                    }
                    remainder20 = 0
                }

                value /= 20
                symbols.insert(symbol, at: 0)
            }
        }
        else {
            symbols.append([#imageLiteral(resourceName: "zeroDown")])
        }
        
        return symbols
    }
}
