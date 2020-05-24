//
//  WeatherForeCastViewController.swift
//  WeatherApp
//
//  Created by Arun Amuri on 05/20/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherForeCastDelegate: class {
    func refreshForecastWeather()
    func showForeCastError(with message: String)
}


class WeatherForeCastViewController: UIViewController {
    
    fileprivate var viewModel: WeatherForecastViewModel?
    @IBOutlet weak var weatherTableView: UITableView!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        weatherTableView.register(UINib(nibName: "WeatherInfomrationCell", bundle: nil), forCellReuseIdentifier: "WeatherInfomrationCell")
        
        loadData()
        setUpcurrentLocation()
        
    }
    
    func loadData() {
        if viewModel == nil {
            viewModel = WeatherForecastViewModel()
            viewModel?.delegate = self
        }
    }
    
    func setUpcurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension WeatherForeCastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        viewModel?.currentLocation = Coord(lat: Double(locValue.latitude), lon: Double(locValue.longitude))
    }
}

extension WeatherForeCastViewController: WeatherForeCastDelegate {
    func refreshForecastWeather() {
        DispatchQueue.main.async { self.weatherTableView.reloadData() }
        
    }
    
    func showForeCastError(with message: String) {
        print("error data \(message)")
    }
}

extension WeatherForeCastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.tableView(numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfomrationCell", for: indexPath) as? WeatherInfomrationCell,
            let info = viewModel?.weatherInforamtion(for: indexPath) else {
                return UITableViewCell()
        }
        cell.configureCell(info: info)
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.tableView(titleForHeaderInSection: section)
    }
}
