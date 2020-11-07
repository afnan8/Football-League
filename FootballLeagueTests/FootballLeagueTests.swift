//
//  FootballLeagueTests.swift
//  FootballLeagueTests
//
//  Created by Afnan on 11/3/20.
//

import XCTest
@testable import FootballLeague

class FootballLeagueTests: XCTestCase {
    
    let vc = TeamsViewController()
    
    func testPaginationInitialValues() {
        XCTAssertEqual(vc.count, 0)
        XCTAssertEqual(vc.start, 0)
        XCTAssertEqual(vc.length, 6)
        XCTAssertFalse(vc.isFinish)
        XCTAssertNotNil(vc.teams)
    }
    
    func testIdExistWhenOpenDetailsPage() {
        vc.getTeamsFromLocalStorage()
        vc.openDetailsViewController(0)
        let detailsVC = vc.teamDetailsViewController
        XCTAssertNotNil(detailsVC.id)
    }
}
