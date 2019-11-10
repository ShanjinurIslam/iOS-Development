//
//  WeatherModel.swift
//  Clima
//
//  Created by Shanjinur Islam on 11/10/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let weatherID:Int
    let cityName:String
    let temperature:Int
    var weatherCondition:String {
        switch weatherID {
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
