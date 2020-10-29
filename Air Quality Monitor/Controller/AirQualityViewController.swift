//
//  ViewController.swift
//  Air Quality Monitor
//
//  Created by Ben Do on 9/25/20.
//  Copyright © 2020 Ben Do. All rights reserved.
//

import UIKit
import CoreLocation

class AirQualityViewController: UIViewController {


    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var searchStateTextField: UITextField!
    @IBOutlet weak var searchCountryTextField: UITextField!
    
    
    var airQualityManager = AirQualityManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        airQualityManager.delegate = self

 
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }

}


//MARK: - UITextFieldDelegate

//extension AirQualityViewController: UITextFieldDelegate {
//    @IBAction func searchPressed(_ sender: UIButton) {
//        searchCityTextField.endEditing(true)
//        searchStateTextField.endEditing(true)
//        searchCountryTextField.endEditing(true)
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchCityTextField.endEditing(true)
//        searchStateTextField.endEditing(true)
//        searchCountryTextField.endEditing(true)
//        print(searchCityTextField.text!)
//        print(searchStateTextField.text!)
//        print(searchCountryTextField.text!)
//        return true
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//        } else {
//            textField.placeholder = "Type something"
//            return false
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//            if let city = searchCityTextField.text, let state = searchCityTextField.text, let country = searchCountryTextField.text {
//            airQualityManager.fetchAirQuality(cityName: city, stateName: state, countryName: country)
//        }
//        searchCityTextField.text = ""
//        searchStateTextField.text = ""
//        searchCountryTextField.text = ""
//    }
//}


//MARK: - AirQualityManagerDelegate

extension AirQualityViewController: AirQualityManagerDelegate {
    
    func didUpdateAirQuality(_ airQualityManager: AirQualityManager, airQuality: AirQualityModel) {
        DispatchQueue.main.async {
            self.airQualityLabel.text = airQuality.airQualityString
            self.airQualityLabel.textColor = airQuality.aqiColor
            self.locationLabel.text = "\(airQuality.cityName), \(airQuality.stateName), \(airQuality.countryName)"
        }
    }
    
    func didUpdateWeather(_ airQualityManager: AirQualityManager, weather: AirQualityModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}


//MARK: - CLLocationManagerDelegate

extension AirQualityViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            airQualityManager.fetchAirQuality(latitude: lat, longitude: lon)
            print(lat)
            print(lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

