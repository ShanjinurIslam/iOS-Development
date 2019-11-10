//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate,WeatherDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextInput: UITextField!
    
    var weather:WeatherManager = WeatherManager()
    
    
    var locationName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextInput.delegate = self
        weather.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func searchPressed(_ sender: UIButton) { // close keyboard after search on button press
        searchTextInput.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // close keyboard after search
        searchTextInput.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { // validation check
        if searchTextInput.text != "" {
            return true
        }
        else {
            searchTextInput.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { // reset text after search
        locationName = searchTextInput.text!
        weather.fetchWeather(cityName: locationName!)
        searchTextInput.text = ""
    }
    
    func didUpdateWeather(_ weatherManager:WeatherManager,_ weather:WeatherModel){
        print(weather.weatherCondition)
        print(weather.weatherID)
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = String(weather.temperature)
            self.conditionImageView.image = UIImage(systemName: weather.weatherCondition)
        }
        //cityLabel.text = weather.cityName
    }
    
    func didFailWithError(_ error:Error){
        print(error)
    }
}

