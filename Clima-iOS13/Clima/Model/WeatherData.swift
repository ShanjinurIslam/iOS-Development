//
//  WeatherData.swift
//  Clima
//
//  Created by Shanjinur Islam on 11/10/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let name:String
    let main:Main
    let weather:[Weather]
}

struct Main: Decodable {
    let temp:Double
}

struct Weather: Decodable {
    let id:Int
    let main:String
    let description:String
}


