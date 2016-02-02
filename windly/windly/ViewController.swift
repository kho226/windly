//
//  ViewController.swift
//  stormy
//
//  Created by Kyle Ong on 1/24/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dailyWeather: DailyWeather? {
        didSet{
            configureView()
        }
        
    }

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    @IBOutlet weak var sunRiseIcon: UIImageView!
    
    @IBOutlet weak var sunRiseTimeLabel: UILabel!
    
    @IBOutlet weak var sunSetIcon: UIImageView!
    
    @IBOutlet weak var sunSetTimeLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var precipChanceLabel: UILabel!
    @IBOutlet weak var humidityChanceLabel: UILabel!
 /*   @IBOutlet weak var currentWeatherSummary: UILabel?
    
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    
    @IBOutlet weak var currentTempLabel: UILabel?
    
    @IBOutlet weak var currentHumidityLabel: UILabel?
    
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var refreshButtonReference: UIButton?
    
    private let forecastAPIKey = "02e95d977a5dd67687d31e9e2f5928fc"
    
    let coordinates: (lat: Double, lon: Double) = (40.7127,74.0059) */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view, typically from a nib.
        //retrieveWeatherForecast()
       
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configureView() {
        if let weather = dailyWeather {
            self.title = weather.day
            weatherIcon?.image = weather.largeIcon
            summaryLabel?.text = weather.summary
            sunRiseTimeLabel?.text = weather.sunRiseTime
            sunSetTimeLabel?.text = weather.sunSetTime
            if let lowTemp = weather.minTemp,
            let highTemp = weather.maxTemp,
            let precipChance = weather.precipChance,
                let humidityChance = weather.humidity{
                    lowTempLabel?.text = "\(lowTemp)"
                    highTempLabel?.text = "\(highTemp)"
                    precipChanceLabel?.text = "\(precipChance)"
                    humidityChanceLabel?.text = "\(humidityChance)"
            }
            
            //configure navbar back button
            if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0){
                let barButtonAttributesDictionary: [String: AnyObject]? =
                    [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName:buttonFont]
                //navigationController?.navigationBar.titleTextAttributes = barButtonAttributesDictionary
                UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
            }
            //update UI with information from the data model
            
        }
    }
  /*
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIkey:forecastAPIKey)
        forecastService.getWeather(coordinates.lat, lon: coordinates.lon){
            (let currently) in
            if let currentWeather = currently{
                dispatch_async(dispatch_get_main_queue()){
                    //execute closure
                    if let temperature = currentWeather.temperature{
                        self.currentTempLabel?.text = "\(temperature)º"
                    }
                    if let humidity = currentWeather.humidity{
                        self.currentHumidityLabel?.text="\(humidity)%"
                    }
                    if let precipitation = currentWeather.precipChance{
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    if let icon = currentWeather.icon{
                        self.currentWeatherIcon?.image = icon
                    }
                    if let summary = currentWeather.summary{
                        self.currentWeatherSummary?.text = summary
                    }
                  //  self.toggleRefreshAnimation(false)
                }
            }
        }
    } */
  /* @IBAction func refreshButton() {
        retrieveWeatherForecast()
        toggleRefreshAnimation(true)
    } */
    
  /*  func toggleRefreshAnimation(on: Bool){
        refreshButtonReference?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    } */
    
}