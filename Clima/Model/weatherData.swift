//
//  weatherData.swift
//  Clima
//
//  Created by administrator on 27/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData: Codable {
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
