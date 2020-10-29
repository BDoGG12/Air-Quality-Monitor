//
//  AirQualityModel.swift
//  Air Quality Monitor
//
//  Created by Ben Do on 10/3/20.
//  Copyright © 2020 Ben Do. All rights reserved.
//

import Foundation
import UIKit

struct AirQualityModel {
    let cityName: String
    let stateName: String
    let countryName: String
    let weatherIC: String
    let airQualityIndex: Int
    
    var conditionName: String {
        switch weatherIC {
        case "01d":
            return "sun.max"
        case "01n":
            return "moon.stars"
        case "02d":
            return "cloud.sun"
        case "03d":
            return "cloud"
        case "04d":
            return "cloud.fill"
        case "09d":
            return "cloud.rain"
        case "10d":
            return "cloud.sun.rain"
        case "10n":
            return "cloud.moon.rain"
        case "11d":
            return "cloud.bolt"
        case "13d":
            return "cloud.snow"
        case "50d":
            return "cloud.drizzle"
        default:
            return "sunrise"
        }
    }
    
    var airQualityString: String {
        return String(airQualityIndex)
    }
    
    var aqiColor: UIColor {
        switch airQualityIndex {
        case 0...50:
            return UIColor.green
        case 51...100:
            return UIColor.yellow
        case 101...150:
            return UIColor.orange
        case 151...200:
            return UIColor.red
        case 201...300:
            return UIColor.purple
        case 301-500:
            return UIColor.brown
        default:
            return UIColor.black
        }
    
        
    }
}


