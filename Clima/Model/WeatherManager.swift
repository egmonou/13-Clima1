//
//  WeatherManager.swift
//  Clima
//
//  Created by administrator on 25/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=71b470e7bdf63fadef56a2f4383bd91d&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //1. Create URL (get the link)
        if let url = URL(string: urlString){
            //2. Create URLSession (open the broswer)
            let session = URLSession(configuration: .default)
            //3. Give the session a task(past the link to browser
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safaData = data {
                    if let weather = self.parseJason(safaData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task(press enter)
            task.resume()
        }
    }
    
    
    func parseJason(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(condtionId: id, cityName: name, temprature: temp)
            return weather
          
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
   
    
}
