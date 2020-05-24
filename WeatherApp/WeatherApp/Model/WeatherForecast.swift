//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Arun Amuri on 05/20/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation


// MARK: - WeatherForeCast
struct WeatherForeCast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dtTxt: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt, name
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        feelsLike = (try? container.decode(Double.self, forKey: .feelsLike)) ?? 0.0
        temp = (try? container.decode(Double.self, forKey: .temp)) ?? 0.0
        tempMin = (try? container.decode(Double.self, forKey: .tempMin)) ?? 0.0
        tempMax = (try? container.decode(Double.self, forKey: .tempMax)) ?? 0.0
        tempKf = (try? container.decode(Double.self, forKey: .tempKf)) ?? 0.0
        
        pressure = (try? container.decode(Int.self, forKey: .pressure)) ?? 0
        seaLevel = (try? container.decode(Int.self, forKey: .seaLevel)) ?? 0
        grndLevel = (try? container.decode(Int.self, forKey: .grndLevel)) ?? 0
        humidity = (try? container.decode(Int.self, forKey: .humidity)) ?? 0
        
        
    }
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure
        case seaLevel
        case grndLevel
        case humidity
        case tempKf
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod?
    
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct WeatherGroup: Codable {
    let cnt: Int
    let list: [List]
}
