//
//  WeatherGroupService.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation


struct WeatherGroupService {
    let cityIds: String
    let unit: String = "metric"
}

extension WeatherGroupService: Buildable {
    var httpRequestType: RequestFactory.Method {
        .GET
    }
    var path: String {
        return "group"
    }
    
    var queryParamertes: [String: String] {
        ["id": cityIds, "units": unit]
    }
}

extension WeatherGroupService {
    
    func getWeatherInformation(completion: @escaping(Result<WeatherGroup, ErrorResult>) -> Void) {
        
        guard let groupIdsRequest = buildRequest() else {
            return
        }
        
        RequestService().loadData(urlRequest: groupIdsRequest) { result in
            
            switch result {
            case .success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let weatherInfo = try decoder.decode(WeatherGroup.self, from: data)
                    completion(.success(weatherInfo))
                } catch let error {
                    completion(.failure(.network(string: "An error occured during parsing of data :" + error.localizedDescription)))
                }
                
            case .failure(let error):
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                print("error desciprion \(error.localizedDescription)")
            }
        }
    }
}
