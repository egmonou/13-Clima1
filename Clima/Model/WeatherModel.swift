//
//  WeatherModel.swift
//  Clima
//
//  Created by administrator on 29/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let condtionId: Int
    let cityName: String
    let temprature: Double
    
    var tempString: String{
        return String(format: "%0.1f", temprature)
        
    }
    
    var conditionName: String{
        switch condtionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
}
