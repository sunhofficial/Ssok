//
//  SsokUITests.swift
//  SsokUITests
//
//  Created by CHANG JIN LEE on 2023/05/23.
//

import XCTest

final class SsokUITests: XCTestCase {
    
    override func setUp() {
            continueAfterFailure = false
            let app = XCUIApplication()
            setupSnapshot(app)
            app.launch()
            
        }

        
        func testScreenshots() {
            
                    
        // 스크린샷을 찍은snapshot() 함수를 호출합니다
            
            
                        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
            snapshot("0Launch")
            
            webViewsQuery.staticTexts["Tour"].tap()
            snapshot("1Main")
                            
         
                
        
        }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
