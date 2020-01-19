//
//  MayanMathTests.swift
//  MayanMathTests
//
//  Created by John C Montiel on 1/18/20.
//  Copyright © 2020 Montiel Mobile, LLC. All rights reserved.
//

import XCTest

class MayanMathTests: XCTestCase {

    var mayanSymbols: [[UIImage]] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMayanSymbols() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(1.mayanSymbols().count == 1)
        XCTAssert(19.mayanSymbols().count == 1)
        XCTAssert(20.mayanSymbols().count == 2)
        XCTAssert(399.mayanSymbols().count == 2)
        XCTAssert(400.mayanSymbols().count == 3)
        XCTAssert(7999.mayanSymbols().count == 3)
        XCTAssert(8000.mayanSymbols().count == 4)
        XCTAssert(159999.mayanSymbols().count == 4)
        XCTAssert(160000.mayanSymbols().count == 5)

        XCTAssert(0.mayanSymbols().first!.first!.isEqual(UIImage(named: "zeroDown", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(1.mayanSymbols().first!.first!.isEqual(UIImage(named: "one", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(2.mayanSymbols().first!.first!.isEqual(UIImage(named: "two", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(3.mayanSymbols().first!.first!.isEqual(UIImage(named: "three", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(4.mayanSymbols().first!.first!.isEqual(UIImage(named: "four", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(5.mayanSymbols().first!.first!.isEqual(UIImage(named: "five", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(10.mayanSymbols().first!.first!.isEqual(UIImage(named: "ten", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(15.mayanSymbols().first!.first!.isEqual(UIImage(named: "fifteen", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(20.mayanSymbols().first!.first!.isEqual(UIImage(named: "one", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(20.mayanSymbols().last!.first!.isEqual(UIImage(named: "zeroDown", in: Bundle(for: MayanMath.self), with: nil)!))
        
        XCTAssert(40.mayanSymbols().first!.first!.isEqual(UIImage(named: "two", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(400.mayanSymbols().first!.first!.isEqual(UIImage(named: "one", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(800.mayanSymbols().first!.first!.isEqual(UIImage(named: "two", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(8000.mayanSymbols().first!.first!.isEqual(UIImage(named: "one", in: Bundle(for: MayanMath.self), with: nil)!))
        XCTAssert(16000.mayanSymbols().first!.first!.isEqual(UIImage(named: "two", in: Bundle(for: MayanMath.self), with: nil)!))
        
    }

    func testMayanImage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(MayanMath.symbols(forInt: 1).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 2).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 3).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 4).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 5).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 6).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 7).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 8).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 9).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 10).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 11).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 12).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 13).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 14).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 15).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 16).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 17).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 18).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 19).count == 1)
        XCTAssert(MayanMath.symbols(forInt: 20).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 21).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 58).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 59).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 60).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 61).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 62).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 399).count == 2)
        XCTAssert(MayanMath.symbols(forInt: 400).count == 3)
        XCTAssert(MayanMath.symbols(forInt: 7999).count == 3)
        XCTAssert(MayanMath.symbols(forInt: 8000).count == 4)
        XCTAssert(MayanMath.symbols(forInt: 159999).count == 4)
        XCTAssert(MayanMath.symbols(forInt: 160000).count == 5)
        XCTAssert(MayanMath.symbols(forInt: Int.max).count > 5)
    }

    func testMayanImagePerformance() {
        // This is an example of a performance test case.
        self.measure {
            let _ = MayanMath.symbols(forInt: Int.max)
        }
    }
}
