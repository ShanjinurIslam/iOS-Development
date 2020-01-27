//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextInput: UITextField!
    
    var weather:WeatherManager = WeatherManager()
    var locationManager:CLLocationManager = CLLocationManager()
    var locationName:String?
    
    @IBAction func onLocationButtonPressed(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        searchTextInput.delegate = self
        weather.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }
}

extension WeatherViewController:UITextFieldDelegate {
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
}

extension WeatherViewController: WeatherDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager,_ weather:WeatherModel){
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

extension WeatherViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let lat = location.coordinate.latitude ;
        let lon = location.coordinate.longitude ;
        weather.fetchWeather(lat: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
