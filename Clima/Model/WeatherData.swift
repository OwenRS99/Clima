//
//  WeatherData.swift
//  Clima
//
//  Created by Owen Swinn on 04/04/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData: Codable{
    let name: String?
    let main: Main
    let timezone: Int
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
    let feels_like: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
    let main: String
    //weather[0].description
}


