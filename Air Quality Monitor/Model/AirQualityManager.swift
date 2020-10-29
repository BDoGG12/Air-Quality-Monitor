//
//  AirQualityManager.swift
//  Air Quality Monitor
//
//  Created by Ben Do on 10/3/20.
//  Copyright © 2020 Ben Do. All rights reserved.
//

import Foundation
import CoreLocation

protocol AirQualityManagerDelegate {
    func didUpdateAirQuality(_ airQualityManager: AirQualityManager, airQuality: AirQualityModel)
    func didUpdateWeather(_ airQualityManager: AirQualityManager, weather: AirQualityModel)
    func didFailWithError(error: Error)
}

struct AirQualityManager {
    let cityURL = "https://api.airvisual.com/v2/city?"
    let nearCityURL = "https://api.airvisual.com/v2/nearest_city?"
    let apiKey = "0a854035-4d07-4155-9cc0-0b39fa79e66c"
    var delegate: AirQualityManagerDelegate?
    
    func fetchAirQuality(cityName: String, stateName: String, countryName: String) {
        let urlString = "\(cityURL)city=\(cityName)&state=\(stateName)&country=\(countryName)&key=\(apiKey)"
        performRequest(urlString: urlString)
        
    }
    
    func fetchAirQuality(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(nearCityURL)lat=\(latitude)&lon=\(longitude)&key=\(apiKey)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
//        1. Create URL
        if let url = URL(string: urlString) {
//            2. Create URL Session
            let session = URLSession(configuration: .default)
            
//            3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let air = self.parseJSON(airData: safeData) {
                        self.delegate?.didUpdateAirQuality(self, airQuality: air)
                    }
                    
                }
            }
//            4. Start the task
            task.resume()
        }
    }
    
    
    func parseJSON(airData: Foundation.Data) -> AirQualityModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AirData.self, from: airData)
            let city = decodedData.data.city 
            let state = decodedData.data.state
            let country = decodedData.data.country
            let aqi = decodedData.data.current.pollution.aqius
            let ic = decodedData.data.current.weather.ic
            
            let air = AirQualityModel(cityName: city, stateName: state, countryName: country, weatherIC: ic, airQualityIndex: aqi)
            return air
        } catch {
            print(error)
            return nil
        }
    }
}
