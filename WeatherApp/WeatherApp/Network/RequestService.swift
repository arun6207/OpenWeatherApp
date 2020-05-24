//
//  RequestService.swift
//  WeatherApp
//
//  Created by Arun Amuri on 05/20/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import Foundation


final class RequestService {
    
    func loadData(urlString: String,
                  session: URLSession = URLSession(configuration: .default),
                  completion: @escaping (Result<Data, ErrorResult>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Wrong url format")))
            return
        }
        
        var request = RequestFactory.request(method: .GET, url: url)
        
        if let reachability = Reachability(), !reachability.isReachable {
            request.cachePolicy = .returnCacheDataDontLoad
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    func loadData(urlRequest: URLRequest,
                  session: URLSession = URLSession(configuration: .default),
                  completion: @escaping (Result<Data, ErrorResult>) -> Void) {
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
}
