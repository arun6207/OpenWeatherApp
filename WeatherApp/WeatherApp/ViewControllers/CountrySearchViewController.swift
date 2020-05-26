//
//  CountrySearchViewController.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import UIKit

class CountrySearchViewController: UIViewController {

  
    @IBOutlet weak var countriesTableView: UITableView!
    weak var delegate: SearchControllerDelegate?
    
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = CountrySearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        
        setupSearchBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }
    
    func setupSearchBarController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Please enter city name"
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        countriesTableView.tableHeaderView = searchController.searchBar
    }
    
}

extension CountrySearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = viewModel.filteredCities[indexPath.row].name
        return cell
    }
}

extension CountrySearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCity = viewModel.filteredCities[indexPath.row]
        viewModel.selectedCities.append(selectedCity)
        
        guard viewModel.hasMaximumAllowedCites else { return }
        
        searchController.searchBar.searchTextField.text = "\(viewModel.selectedCityNames),"
    }
}

extension CountrySearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCities(with: searchText) {
            DispatchQueue.main.async {
                self.countriesTableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if viewModel.hasValidNumberOfCities {
            delegate?.selctedCities(viewModel.selectedCities)
            dismiss(animated: true, completion: nil)
        } else {
        showInvalidNumberOfCitiesAlert()
        }
    }
}

extension CountrySearchViewController {
    func showInvalidNumberOfCitiesAlert() {
        
        let title = "Select valid number of cities"
        let message = "Min is 3 and Max is 7."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (okButton) in
            self.searchController.isActive = true
            self.searchController.searchBar.searchTextField.becomeFirstResponder()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
