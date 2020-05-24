//
//  ErrorResult.swift
//  WeatherApp
//
//  Created by Arun Amuri on 05/20/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
