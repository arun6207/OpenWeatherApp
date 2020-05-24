//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Arun Amuri on 05/20/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    fileprivate enum SelectedButtonTag: Int {
        case Step1
        case Step2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        switch sender.tag {
        case SelectedButtonTag.Step1.rawValue:
            
            if  let vc = WeatherInforamtionViewController.instantiate(with: StopryBoards.main,
                                                                      identifier: WeatherInforamtionViewController.viewIdentifier) {
                
                navigationController?.pushViewController(vc, animated: true)
            }
        case SelectedButtonTag.Step2.rawValue:
            
            if  let vc = WeatherForeCastViewController.instantiate(with: StopryBoards.main,
                                                                   identifier: WeatherForeCastViewController.viewIdentifier) {
                
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            print("Selected option doesnt exists")
        }
    }
}
