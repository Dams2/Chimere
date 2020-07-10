//
//  ChimereUITests.swift
//  ChimereUITests
//
//  Created by Damien Rojo on 12.05.20.
//  Copyright © 2020 Damien Rojo. All rights reserved.
//

import XCTest

class ChimereUITests: XCTestCase {
    
    var app: XCUIApplication!

   override func setUp() {
       super.setUp()
       app = XCUIApplication()
       app.launchEnvironment = ["RUNNING_UI_TESTS": "YES"]
        setupSnapshot(app)
       app.launch()
   }

   func test_Snapshot() {
       snapshot("0")
   }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
