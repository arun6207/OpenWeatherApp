//
//  Result.swift
//  WeatherApp
//
//  Created by Arun Amuri on 05/20/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
