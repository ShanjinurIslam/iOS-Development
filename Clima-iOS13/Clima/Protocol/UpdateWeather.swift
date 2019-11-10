//
//  UpdateWeather.swift
//  Clima
//
//  Created by Shanjinur Islam on 11/10/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherDelegate {
    func didUpdateWeather(weather:WeatherModel)
}
