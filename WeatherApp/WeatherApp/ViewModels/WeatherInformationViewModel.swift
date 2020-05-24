//
//  WeatherInformationViewModel.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation

protocol WeatherGroupInformationDelegate: class {
    func updateWeatherInfo()
}

class WeatherInformationViewModel {
    
    var groupCityService: WeatherGroupService?
    weak var delegate: WeatherGroupInformationDelegate?
    
    var selectedCities = [CityInfo]() {
        didSet {
            fetchWeatherInfo()
        }
    }
    
    var citiesWeatherInfo: WeatherGroup? {
        didSet {
            delegate?.updateWeatherInfo()
        }
    }
    
    //init we can initialize service
    
    func fetchWeatherInfo() {
        
        let selectedCityIds = selectedCities.map { return String($0.id) }.joined(separator: ",")
        
        groupCityService = WeatherGroupService(cityIds: selectedCityIds)
        
        groupCityService?.getWeatherInformation(completion: { (result) in
            switch result {
            case .success(let weatherInfo):
                self.citiesWeatherInfo = weatherInfo
            case .failure(let error):
                print("error while fetching \(error.localizedDescription)")
            }
        })
    }
    
}
