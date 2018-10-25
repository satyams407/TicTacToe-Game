//
//  MutualMobileCodingTestTests.swift
//  MutualMobileCodingTestTests
//
//  Created by Satyam Sehgal on 25/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import XCTest
@testable import MutualMobileCodingTest

class MutualMobileCodingTestTests: XCTestCase {
    var gameLogic: GameLogic?

    override func setUp() {
        super.setUp()
        self.gameLogic = GameLogic()
    }

    func testgetRowIndex(index: Int, gridSize: Int) {
        let index = 3
        let gridSize = 9
        let result = index/gridSize
        XCTAssertTrue(result < gridSize, "number of rows cannot be more than grid size")
    }

    override func tearDown() {
       super.tearDown()
       self.gameLogic = nil
    }


}
