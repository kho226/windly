//
//  forecast.swift
//  stormy
//
//  Created by Kyle Ong on 1/28/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import Foundation

struct Forecast{
    var currentWeather: CurrentWeather?
    var weekly: [DailyWeather] = []
    
    init (weatherDict: [String: AnyObject]?){
        if let currentWeatherDict = weatherDict?["currently"] as? [String: AnyObject]{
            currentWeather = CurrentWeather(weatherDict: currentWeatherDict)
        }
        if let weeklyWeatherArray = weatherDict!["daily"]?["data"] as? [[String: AnyObject]]{
            for dailyWeather in weeklyWeatherArray {
                let daily = DailyWeather(dailyWeatherDict: dailyWeather)
                weekly.append(daily)
            }
        }

    }
}
//struct to hold an array of daily-weathers for the weekly forecast
//struct to hold the current weather
//takes a dictionary of [String: AnyObject?]
//if the [""currently"] key exists in the passed in dictionary, pass into the CurrentWeather initializer and assign it to an instance of currentWeather -> currentWeather
//the passed in weatherDict has an array of dictionaries stored under the key ["Daily"]?["data"]
//assign the array of dictionaries to a local array 
//pass each dictionary in the array pass it into the DailyWeather initializer and append it to the weekly weather array property of the struct