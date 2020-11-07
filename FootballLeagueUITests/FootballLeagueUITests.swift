//
//  FootballLeagueUITests.swift
//  FootballLeagueUITests
//
//  Created by Afnan on 11/3/20.
//

import XCTest

class FootballLeagueUITests: XCTestCase {

    var application = XCUIApplication(bundleIdentifier: "Com.Orcas.FootballLeague")
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        application.launch()
        
    }
    
    override func tearDownWithError() throws {
    }
    
    func testTeamRequiredFieldsExist() throws { //UI Test scucceeded when read from local database
        let app = XCUIApplication()
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        let collectionView = app.collectionViews["teamCollectionViewIdentifier"]
        let cell = collectionView.cells["teamCellIdentifier"]
        let nameLabel = cell.firstMatch.staticTexts["nameLabelIdnetifier"]
        let websiteButton = cell.firstMatch.buttons["websiteButtonIdentifier"]
        let colorLabel = cell.firstMatch.staticTexts["colorLabelIdentifier"]
        let venueLabel = cell.firstMatch.staticTexts["VenueLabelIdentifier"]
        
        XCTAssert(cell.exists)
        XCTAssert(nameLabel.exists)
        XCTAssert(websiteButton.exists)
        
        websiteButton.tap()
        _ = safari.wait(for: .runningForeground, timeout: 30)
        app.activate() // <--- Go back to your app

        XCTAssert(colorLabel.exists)
        XCTAssert(venueLabel.exists)
       
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
