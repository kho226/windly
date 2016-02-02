//
//  dailyWeatherTableViewCell.swift
//  stormy
//
//  Created by Kyle Ong on 1/29/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import UIKit

class dailyWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!

    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
