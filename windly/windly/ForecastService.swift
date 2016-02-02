//
//  ForecastService.swift
//  stormy
//
//  Created by Kyle Ong on 1/24/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

//retrieve weather

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    
    let forecastBaseURL: NSURL?
    
    init(APIkey: String){
        self.forecastAPIKey = APIkey
        self.forecastBaseURL = NSURL(string:"https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
   /* func currentWeatherFromJSONDict(jsonDictionary: [String: AnyObject]?) -> CurrentWeather?{
        if let currentWeatherDict = jsonDictionary?["currently"] as? [String: AnyObject]{
            return CurrentWeather(weatherDict: currentWeatherDict)
        }else {
            print ("jsonDictionary returned nil for 'currently' key")
            return nil
        }
    } */
    
    func getWeather(lat: Double, lon: Double, completion:(Forecast? -> Void)){
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeToURL: forecastBaseURL) {
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSONFromURL{(let JSONDictionary) in
                let forecast = Forecast(weatherDict: JSONDictionary)
                    completion(forecast)
            }
            
        }else{
            print("Could not construct a valid URL")
        }
    }
    
}