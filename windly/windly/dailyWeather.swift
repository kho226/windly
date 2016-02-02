//
//  dailyWeather.swift
//  stormy
//
//  Created by Kyle Ong on 1/28/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather{
    let maxTemp: Int?
    let minTemp: Int?
    let humidity: Int?
    let precipChance: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    var largeIcon: UIImage? = UIImage(named: "default_large.png")
    var sunRiseTime: String?
    var sunSetTime: String?
    var day: String?
    let dateFormatter = NSDateFormatter()
    
    init(dailyWeatherDict: [String: AnyObject]){
        maxTemp = dailyWeatherDict["temperatureMax"] as? Int
        minTemp = dailyWeatherDict["temperatureMin"] as? Int
        if let humidityFloat = dailyWeatherDict["humidity"] as? Double{
            humidity = Int(humidityFloat * 100)
        }else{
            humidity = nil
        }
        if let precipChanceFloat = dailyWeatherDict["precipProbability"] as? Double{
            precipChance = Int(precipChanceFloat * 100)
        }else {
            precipChance = nil
        }
        summary = dailyWeatherDict["summary"] as? String
        
        if let iconString = dailyWeatherDict["icon"] as? String, let iconEnum = Icon(rawValue: iconString){
            (icon, largeIcon) = iconEnum.toImage()
        }
        if let sunRiseDate = dailyWeatherDict["sunriseTime"] as? Double {
            sunRiseTime = timeStringFromUnixTime(sunRiseDate)
        }
        if let sunSetDate = dailyWeatherDict["sunsetTime"] as? Double {
            sunSetTime = timeStringFromUnixTime(sunSetDate)
        }
        if let time = dailyWeatherDict["time"] as? Double {
            day = dayStringFromTime(time)
        }
        
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate (timeIntervalSince1970: unixTime)
        //returns date formatted as twelve hour time
        dateFormatter.dateFormat = "hh:mm a" //specific format of the returned date string
        return dateFormatter.stringFromDate(date)
    }
    
    func dayStringFromTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEEE" //specific format of the returned date string
        return dateFormatter.stringFromDate(date)
    }

}

//constant properties all must be assigned before assigning var properties
//two member functions to handle converting unixTime: Double to Strings
//optional unwrapping to test for the passed the optional passed in dictionary