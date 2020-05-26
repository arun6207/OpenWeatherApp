//
//  RequestBuild.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation

let baseUrl = "http://api.openweathermap.org/data/2.5/"
let appId = "b53b286466bfc92572bb281c1dc99413"
/**
 Types adopting the `Buildable` protocol can be used to build dictionary of parameters.
 */
 protocol Buildable {
    
    /// API Path for the request - should not start with "/"
    var path: String { get }
    
    /// Optional - Defaults to .90
    var httpTimeout: Double { get }
    
    /// Optional - Defaults to nil
    var queryParamertes: [String : String] { get }
    
    var httpRequestType: RequestFactory.Method { get }
}

 extension Buildable {
    
    var httpTimeout: Double {
         60.0
    }
    
    var queryParamertes: [String : String] {
        return [:]
    }
}

extension Buildable {
    /// Builds a URL Request object
    func buildRequest() -> URLRequest? {
        assert(!path.hasPrefix("/"), "Path should NOT start with a '/'")
        
        // Building the Request object
        let urlString =  baseUrl + path
        var items = [URLQueryItem]()
        var urlComponents = URLComponents(string: urlString)
    
        for (key,value) in queryParamertes {
            items.append(URLQueryItem(name: key, value: value))
        }
        items.append(URLQueryItem(name: "appId", value: appId))
        
        urlComponents?.queryItems = items
        
        guard let finalUrl = urlComponents?.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: finalUrl)
        urlRequest.httpMethod = httpRequestType.rawValue
        
        return urlRequest
    }
}
