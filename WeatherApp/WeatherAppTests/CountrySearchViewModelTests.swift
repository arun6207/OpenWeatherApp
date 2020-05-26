//
//  CountrySearchViewModelTest.swift
//  WeatherAppTests
//
//  Created by Arun Amuri on 26/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import XCTest
@testable import WeatherApp

class CountrySearchViewModelTests: XCTestCase {
    
    var viewModel: CountrySearchViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CountrySearchViewModel()
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
    
    func testExistanceOfCites() {
        XCTAssertTrue(viewModel.cities.count > 0, "we should have one or more number of cities")
    }
    
    func testValidNumberOfSelectedCities() {
        viewModel.selectedCities = [CityInfo(id: 1, name: "London", state: "State1", country: "Country", coord: Coord(lat: 20.0, lon: 20.0)),
                                    CityInfo(id: 2, name: "Lauxmberg", state: "State2", country: "Country", coord: Coord(lat: 20.0, lon: 20.0))]
        
        XCTAssertFalse(viewModel.hasValidNumberOfCities, "we should have minimum 3 and maximum 7 number of selected cities")
        XCTAssertTrue(viewModel.hasMaximumAllowedCites, "we should have maximum 7 selected cities")
    }
    
    func testSelctedCityNames() {
        viewModel.selectedCities = [CityInfo(id: 1, name: "London", state: "State1", country: "Country", coord: Coord(lat: 20.0, lon: 20.0)),
                                         CityInfo(id: 2, name: "Lauxmberg", state: "State2", country: "Country", coord: Coord(lat: 20.0, lon: 20.0))]
        
        XCTAssertEqual(viewModel.selectedCityNames, "London,Lauxmberg")
    }
}

