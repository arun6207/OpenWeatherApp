//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//


import Foundation

class WeatherForecastViewModel {
    
    weak var delegate: WeatherForeCastDelegate?
    fileprivate var forecastService: ForeCastService?
    fileprivate  var forecastInfo: [ForeCastInforamtion]?
    
    var numberOfSections: Int {
        return forecastInfo?.count ?? 0
    }
    
    var currentLocation: Coord? {
        didSet {
            ///we should change this position of call 
            weatherForeCastLoadData()
        }
    }
    
    func tableView(numberOfRowsInSection section: Int) -> Int {
        guard let details = forecastInfo else { return 0 }
        return details[section].list.count
    }
    
    func tableView(titleForHeaderInSection section: Int) -> String? {
        guard let details = forecastInfo else { return "" }
        return details[section].displayDate
    }
    
    
    func weatherInforamtion(for indexPath: IndexPath) -> List? {
        guard let weatherInfo = forecastInfo?[indexPath.section].list[indexPath.row] else { return nil }
        return weatherInfo
    }
    
    
    private func weatherForeCastLoadData() {
        
        guard let location = currentLocation else { return }
        
        forecastService = ForeCastService(currentLocation: location)
        forecastService?.forecastWeatherInfo({ (result) in
            switch result {
            case .success(let forecastInfo):
                self.groupAndSortForecast(details: forecastInfo)
            case .failure(let error):
                self.delegate?.showForeCastError(with: error.localizedDescription)
            }
        })
    }
}

extension WeatherForecastViewModel {
    
    struct ForeCastInforamtion {
        let displayDate: String
        let list: [List]
    }
    
    func groupAndSortForecast(details: WeatherForeCast) {
        
        let values = details.list
        
        let dictionary = Dictionary(grouping: values, by: { (element: List) in
            return String(element.dtTxt?.dropLast(9) ?? "")
        })
        
        let sorted = dictionary.sorted(by: { (element1, element2) -> Bool in
            return element1.0  < element2.0
        })
        
        forecastInfo = [ForeCastInforamtion]()
        
        for (date,listInfo) in sorted {
            forecastInfo?.append(WeatherForecastViewModel.ForeCastInforamtion(displayDate: date, list: listInfo))
        }
        
        delegate?.refreshForecastWeather()
    }
    
}
