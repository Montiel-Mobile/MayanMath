//
//  MayanMathTests.swift
//  MayanMathTests
//
//  Created by John C Montiel on 1/18/20.
//  Copyright © 2020 Montiel Mobile, LLC. All rights reserved.
//

import XCTest

class MayanMathTests: XCTestCase {

    var mayanEngine = MayanMath()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testmayanSymbols() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(1.mayanSymbols(.flat).count == 1)
        XCTAssert(19.mayanSymbols(.flat).count == 1)
        XCTAssert(20.mayanSymbols(.flat).count == 2)
        XCTAssert(399.mayanSymbols(.flat).count == 2)
        XCTAssert(400.mayanSymbols(.flat).count == 3)
        XCTAssert(7999.mayanSymbols(.flat).count == 3)
        XCTAssert(8000.mayanSymbols(.flat).count == 4)
        XCTAssert(159999.mayanSymbols(.flat).count == 4)
        XCTAssert(160000.mayanSymbols(.flat).count == 5)

        XCTAssert(0.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.zeroDown, .flat, false)))
        XCTAssert(1.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.one, .flat, false)))
        XCTAssert(2.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.two, .flat, false)))
        XCTAssert(3.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.three, .flat, false)))
        XCTAssert(4.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.four, .flat, false)))
        XCTAssert(5.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.five, .flat, false)))
        XCTAssert(10.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.ten, .flat, false)))
        XCTAssert(15.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.fifteen, .flat, false)))
        XCTAssert(20.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.one, .flat, false)))
        XCTAssert(20.mayanSymbols(.flat).last!.first!.isEqual(UIImage.symbol(.zeroDown, .flat, false)))
        
        XCTAssert(40.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.two, .flat, false)))
        XCTAssert(400.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.one, .flat, false)))
        XCTAssert(800.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.two, .flat, false)))
        XCTAssert(8000.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.one, .flat, false)))
        XCTAssert(16000.mayanSymbols(.flat).first!.first!.isEqual(UIImage.symbol(.two, .flat, false)))
        
    }
    
    func testMayanOperations() {
        
        // Test negation of left side operand
        mayanEngine.leftSideDigitValues = [1]
        mayanEngine.deriveResults()
        let positive = mayanEngine.leftSide!
        mayanEngine.negate()
        let negative = mayanEngine.leftSide!
        XCTAssert(positive > negative)
        
        // Test multiplication
        mayanEngine.mathOp = .multiply
        mayanEngine.rightSideDigitValues = [-3]
        mayanEngine.equalEnabled = true
        mayanEngine.deriveResults()
        XCTAssert(mayanEngine.resultsInt! == 3)
        
        // Test addition with starting int of the prior result
        mayanEngine.reset(withInt: mayanEngine.resultsInt!)
        mayanEngine.mathOp = .add
        mayanEngine.rightSideDigitValues = [7]
        mayanEngine.equalEnabled = true
        mayanEngine.deriveResults()
        XCTAssert(mayanEngine.resultsInt! == 10)
        
        // Test division
        mayanEngine.reset(withInt: mayanEngine.resultsInt!)
        mayanEngine.mathOp = .divide
        mayanEngine.rightSideDigitValues = [5]
        mayanEngine.equalEnabled = true
        mayanEngine.deriveResults()
        XCTAssert(mayanEngine.resultsInt! == 2)
        
        // Test subtraction
        mayanEngine.reset(withInt: mayanEngine.resultsInt!)
        mayanEngine.mathOp = .subtract
        mayanEngine.rightSideDigitValues = [5]
        mayanEngine.equalEnabled = true
        mayanEngine.deriveResults()
        XCTAssert(mayanEngine.resultsInt! == -3)
        
        // Test negation of right side operand
        mayanEngine.reset(withInt: mayanEngine.resultsInt!)
        mayanEngine.mathOp = .multiply
        mayanEngine.rightSideDigitValues = [10]
        mayanEngine.negate()
        mayanEngine.equalEnabled = true
        mayanEngine.deriveResults()
        XCTAssert(mayanEngine.resultsInt! == 30)

    }

    func testMayanImage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(MayanMath.symbols(forInt: 1, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 2, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 3, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 4, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 5, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 6, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 7, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 8, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 9, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 10, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 11, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 12, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 13, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 14, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 15, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 16, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 17, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 18, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 19, .flat).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 20, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 21, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 58, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 59, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 60, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 61, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 62, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 399, .flat).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 400, .flat).count == 3)
        XCTAssert(MayanMath.symbols(forInt: 7999, .flat).count == 3)
        XCTAssert(MayanMath.symbols(forInt: 8000, .flat).count == 4)
        XCTAssert(MayanMath.symbols(forInt: 159999, .flat).count == 4)
        XCTAssert(MayanMath.symbols(forInt: 160000, .flat).count == 5)
        XCTAssert(MayanMath.symbols(forInt: Int.max, .flat).count > 5)
    }

    func testMayanImagePerformance() {
        // This is an example of a performance test case.
        self.measure {
            let _ = MayanMath.symbols(forInt: Int.max, .flat)
        }
    }
}
