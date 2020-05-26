//
//  CountrySearchViewModel.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation

class CountrySearchViewModel {
    
    let cities = Bundle.main.decode(Cities.self, from: "cities.json")
    
    struct Constants {
        static let maxAllowedCities = 7
        static let minAllowedCities = 3
    }
    
    var filteredCities = [CityInfo]()
    
    var selectedCities = [CityInfo]()
    
    
    var hasValidNumberOfCities: Bool {
        return hasMaximumAllowedCites && selectedCities.count >= Constants.minAllowedCities
    }
    
    var selectedCityNames: String {
        return selectedCities.map { return $0.name }.joined(separator: ",")
    }
    
    var hasMaximumAllowedCites: Bool {
        return selectedCities.count <= Constants.maxAllowedCities
    }
    
    func searchCities(with prefix: String, completionHandler: (() -> Void))  {
        
        let numberOfSelctedCities = prefix.split(separator: ",")
        
        guard let lastElement = numberOfSelctedCities.last,
            numberOfSelctedCities.count <= Constants.maxAllowedCities else { return }
        
        let pattern = "\\b" + NSRegularExpression.escapedPattern(for: String(lastElement))
        
        let matchedCities = cities.filter {
            $0.name.range(of: pattern, options: [.regularExpression,.caseInsensitive]) != nil
        }
        
        filteredCities = matchedCities
        completionHandler()
    }
}
