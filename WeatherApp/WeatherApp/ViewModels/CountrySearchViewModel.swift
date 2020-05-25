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
    var filteredCities = [CityInfo]()
    
    var selectedCities = [CityInfo]()
    
    
    var hasValidumberOfCities: Bool {
        return selectedCities.count < 8 && selectedCities.count >= 3
    }
    
    func searchCities(with prefix: String, completionHandler: (() -> Void))  {
        
        let enteredText = prefix.split(separator: ",")
        
        guard let lastElement = enteredText.last,
            enteredText.count < 8 else { return }
        
        let pattern = "\\b" + NSRegularExpression.escapedPattern(for: String(lastElement))
        
        let matchedCities = cities.filter {
            $0.name.range(of: pattern, options: [.regularExpression,.caseInsensitive]) != nil
        }
        
        filteredCities = matchedCities
        completionHandler()
    }
}
