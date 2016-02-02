//
//  currentWeather.swift
//  stormy
//
//  Created by Kyle Ong on 1/24/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import Foundation
import UIKit


struct CurrentWeather {
    let temperature: Int?
    let humidity: Int?
    let precipChance: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
    init(weatherDict: [String: AnyObject]){
        temperature = weatherDict["temperature"] as? Int
        if let humidityFloat = weatherDict["humidity"] as? Float{
            humidity = Int(humidityFloat * 100)
        }else{
            humidity = nil
        }
        if let precipChanceFloat = weatherDict["precipProbability"] as? Float{
        precipChance = Int(precipChanceFloat * 100)
        }else{
            precipChance = nil
        }
        summary = weatherDict["summary"] as? String
        
        if let iconString = weatherDict["icon"] as? String, let weatherIcon: Icon = Icon(rawValue: iconString){
            (icon,_ ) = weatherIcon.toImage()//icon struct now returns a tuple 01/28/2016
        }
    }
    
    
}

    
    
    
    
    
    
    
    
