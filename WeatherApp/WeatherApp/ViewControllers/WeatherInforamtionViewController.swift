//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Arun Amuri on 05/20/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import UIKit

protocol SearchControllerDelegate: class {
    func selctedCities(_ cities: [CityInfo])
}

class WeatherInforamtionViewController: UIViewController {
    
    @IBOutlet weak var weatherInfoTableView: UITableView!
    var viewModel = WeatherInformationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Information"
        
        weatherInfoTableView.register(UINib(nibName: "WeatherInfomrationCell", bundle: nil), forCellReuseIdentifier: "WeatherInfomrationCell")
        weatherInfoTableView.dataSource = self
        viewModel.delegate = self
    }
    
    @IBAction func addBarButtonclicked(_ sender: Any) {
        
        if let countryListVc = CountrySearchViewController.instantiate(with: StopryBoards.main, identifier: CountrySearchViewController.viewIdentifier) {
            countryListVc.delegate = self
            present(countryListVc, animated: true, completion: nil)
        }
    }
    
}

extension WeatherInforamtionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.citiesWeatherInfo?.cnt ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.citiesWeatherInfo?.list[section].name ?? ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfomrationCell", for: indexPath) as? WeatherInfomrationCell,
        let info = viewModel.citiesWeatherInfo?.list[indexPath.section] else {
            return UITableViewCell()
        }
        cell.configureCell(info: info)
        return cell
    }
}

extension WeatherInforamtionViewController: SearchControllerDelegate {
    func selctedCities(_ cities: [CityInfo]) {
        viewModel.selectedCities = cities
    }
}

extension WeatherInforamtionViewController: WeatherGroupInformationDelegate {
    func updateWeatherInfo() {
        DispatchQueue.main.async {
            self.weatherInfoTableView.reloadData()
        }
        
    }
}
