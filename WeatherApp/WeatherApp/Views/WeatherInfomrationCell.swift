//
//  WeatherInfomrationCell.swift
//  WeatherApp
//
//  Created by Arun Amuri on 24/05/2020.
//  Copyright © 2020 Arun Amuri. All rights reserved.
//

import UIKit

class WeatherInfomrationCell: UITableViewCell {
    
    @IBOutlet weak var temperatureTitleLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var windTitleLabel: UILabel!
    @IBOutlet weak var windValueLabel: UILabel!
    
    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var weatherValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(info: List) {
        maxTempLabel.text = "\(info.main.tempMax)"
        minTempLabel.text = "\(info.main.tempMin)"
        weatherValueLabel.text = info.weather.first?.weatherDescription ?? ""
        windValueLabel.text = "\(info.wind.speed) m/sec"
    }
    
}
