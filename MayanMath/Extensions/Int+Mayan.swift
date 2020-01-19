//
//  Int+Mayan.swift
//  MayanCalc
//
//  Created by John C Montiel on 1/17/19.
//  Copyright © 2020 Montiel Mobile, LLC. All rights reserved.
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
                        symbol.append(UIImage(named: "one", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 2:
                        symbol.append(UIImage(named: "two", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 3:
                        symbol.append(UIImage(named: "three", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 4:
                        symbol.append(UIImage(named: "four", in: Bundle(for: MayanMath.self), with: nil)!)
                    default:
                        break
                    }
                    
                    remainder20 /= 5
                    switch remainder20 {
                    case 0:
                        symbol.append(UIImage(named: "zeroDown", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 1:
                        symbol.append(UIImage(named: "five", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 2:
                        symbol.append(UIImage(named: "ten", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 3:
                        symbol.append(UIImage(named: "fifteen", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 4:
                        symbol.append(UIImage(named: "five", in: Bundle(for: MayanMath.self), with: nil)!)
                        symbol.append(UIImage(named: "zero", in: Bundle(for: MayanMath.self), with: nil)!)
                    default:
                        break
                    }
                }
                else {
                    switch remainder20 {
                    case 0:
                        symbol.append(UIImage(named: "zeroDown", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 1:
                        symbol.append(UIImage(named: "one", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 2:
                        symbol.append(UIImage(named: "two", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 3:
                        symbol.append(UIImage(named: "three", in: Bundle(for: MayanMath.self), with: nil)!)
                    case 4:
                        symbol.append(UIImage(named: "four", in: Bundle(for: MayanMath.self), with: nil)!)
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
            symbols.append([UIImage(named: "zeroDown", in: Bundle(for: MayanMath.self), with: nil)!])
        }
        
        return symbols
    }
}
