//
//  weatherManager.swift
//  Clima
//
//  Created by Owen Swinn on 01/04/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherManagerDelegate{
    func didupdateWeather(_ weatherManger: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let WeatherURL =
    "https://api.openweathermap.org/data/2.5/weather?appid=4a40c71ff26ff9ae582da2ac8db2f94e&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String)
    {
        let urlString = ("\(WeatherURL)&q=\(cityName)")
        performRequest(with: urlString)
    }
    
    func fetchWeather(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees)
    {
        let urlString = ("\(WeatherURL)&lat=\(lat)&lon=\(lon)")
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String)
    {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URL session
            let session = URLSession(configuration: .default)
            // 3. Give session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didupdateWeather(self, weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionId: id, name: name!, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
