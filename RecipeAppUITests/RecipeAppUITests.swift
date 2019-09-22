//
//  RecipeAppUITests.swift
//  RecipeAppUITests
//
//  Created by Avital Miskella on 22/9/19.
//  Copyright © 2019 Avital Miskella. All rights reserved.
//

import XCTest

class RecipeAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.image, identifier:"pancakes").element.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["1.0 Cups Butter"]/*[[".cells.staticTexts[\"1.0 Cups Butter\"]",".staticTexts[\"1.0 Cups Butter\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["70.0 Mililitres Milk"]/*[[".cells.staticTexts[\"70.0 Mililitres Milk\"]",".staticTexts[\"70.0 Mililitres Milk\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
                // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
