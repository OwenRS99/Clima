//
//  WeatherModel.swift
//  Clima
//
//  Created by Owen Swinn on 05/04/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel
{
    let conditionId: Int
    let name: String
    let temperature: Double
    
    var temperatureString: String{
        return String(format: "%.1f", temperature.rounded() )
    }
    
    var conditionName: String{
        
        switch conditionId
        {
        case 200...232:
            return "cloud.bold.rain"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "error"
        }
    }
}
