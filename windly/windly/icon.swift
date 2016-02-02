//
//  icon.swift
//  stormy
//
//  Created by Kyle Ong on 1/28/16.
//  Copyright © 2016 Kyle Ong. All rights reserved.
//

import Foundation
import UIKit


enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    
    func toImage() -> (regularIcon: UIImage?, largeIcon: UIImage?){
        var imageName: String
        switch self {
        case .ClearDay:
            imageName = "clear-day"
        case .ClearNight:
            imageName = "clear-night"
        case .Rain:
            imageName = "rain"
        case .Snow:
            imageName = "snow"
        case .Sleet:
            imageName = "sleet"
        case .Wind:
            imageName = "wind"
        case .Fog:
            imageName = "fog"
        case .Cloudy:
            imageName = "cloudy"
        case .PartlyCloudyDay:
            imageName = "cloudy-day"
        case .PartlyCloudyNight:
            imageName = "cloudy-night"
        }
        let largeIcon = UIImage(named: "\(imageName)_large.png")
        let regularIcon = UIImage(named: "\(imageName).png")
        
        return (regularIcon,largeIcon)
    }
    
}

//returns a tuple of large icon and small icon