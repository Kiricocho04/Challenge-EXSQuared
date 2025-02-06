//
//  TheCatUITests.swift
//  Challenge EXSQuaredUITests
//
//  Created by Matias Nicolas Morales on 06/02/2025.
//

import XCTest

class TheCatUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testListLoadsAndNavigatesToDetail() {
        // Given
        let catList = app.otherElements["CatList"]
        XCTAssertTrue(catList.waitForExistence(timeout: 10))

        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10))

        // When
        firstCell.tap()

        // Then
        let detailTitle = app.staticTexts["Cat Details"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 5))
    }

}
