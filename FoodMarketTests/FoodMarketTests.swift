//
//  FoodMarketTests.swift
//  FoodMarketTests
//
//  Created by ngurah on 17/02/21.
//

import XCTest

@testable
import FoodMarket

class FoodMarketTests: XCTestCase {

    func testTitleName() {
        XCTAssertEqual(TitleName.home, "Home")
        XCTAssertEqual(TitleName.favorite, "Favorite")
        XCTAssertEqual(TitleName.profile, "About Me")
    }
}
