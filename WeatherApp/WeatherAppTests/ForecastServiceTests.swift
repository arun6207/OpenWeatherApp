//
//  ForecastServiceTests.swift
//  WeatherAppTests
//
//  Created by Arun Amuri on 26/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import XCTest
import Foundation
@testable import WeatherApp

class ForecastServiceTests: XCTestCase {
    
    var forecastApi: ForeCastService!
    
    override func setUp() {
        forecastApi = ForeCastService(currentLocation: Coord(lat: 10.0, lon: 20.0))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testServiceRequestURL() {
        let serviceUrl = URL(string: "\(baseUrl)forecast?lat=10.0&lon=20.0&appId=\(appId)")
        XCTAssertEqual(forecastApi.buildRequest()?.url, serviceUrl)
    }
}
