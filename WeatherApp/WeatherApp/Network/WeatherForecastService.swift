//
//  WeatherForecastService.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation


struct ForeCastService {
    let currentLocation: Coord
}

extension ForeCastService: Buildable {
    var httpRequestType: RequestFactory.Method {
        .GET
    }
    
    var path: String {
        return "forecast"
    }
    
    var queryParamertes: [String: String] {
        ["lat": "\(currentLocation.lat)", "lon": "\(currentLocation.lon)"]
    }
}


extension ForeCastService {
    func forecastWeatherInfo(_ completion: @escaping(Result<WeatherForeCast, ErrorResult>) -> Void) {
        guard let urlRequest = buildRequest() else {
            return
        }
        
        RequestService().loadData(urlRequest: urlRequest) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let weatherForeCast = try? decoder.decode(WeatherForeCast.self, from: data) else {
                        return completion(.failure(.parser(string: "An error occured during parsing")))
                    }
                    completion(.success(weatherForeCast))
                } catch let error {
                    completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                }
                
            case .failure(let error):
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                print("error desciprion \(error.localizedDescription)")
            }
        }
    }
}
