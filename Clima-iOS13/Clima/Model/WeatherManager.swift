//
//  WeatherManager.swift
//  Clima
//
//  Created by Shanjinur Islam on 11/10/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager,_ weather: WeatherModel)
    func didFailWithError(_ error:Error)
}

struct WeatherManager {
    
    var delegate:WeatherDelegate?
    let api:String = "https://api.openweathermap.org/data/2.5/weather?APPID=067d6e3ec1ff73e774b20200caa39151&units=metric"
    
    func fetchWeather(cityName:String){
        let urlString = api + "&q=" + cityName ;
        performRequest(urlString)
    }
    
    func fetchWeather(lat:Double,lon:Double){
        let urlString = api + "&lat=" + "\(lat)" + "&lon=" + "\(lon)" ;
        performRequest(urlString)
    }
    
    func performRequest(_ urlString:String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data:Data?,response:URLResponse?,error:Error?) -> Void in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData: safeData) {
                        self.delegate?.didUpdateWeather(self,weather)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(safeData:Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self,from: safeData)
            let weatherID = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(weatherID: weatherID, cityName: name, temperature: Int(temp))
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
