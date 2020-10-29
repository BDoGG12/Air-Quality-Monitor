//
//  AirData.swift
//  Air Quality Monitor
//
//  Created by Ben Do on 10/19/20.
//  Copyright © 2020 Ben Do. All rights reserved.
//

import Foundation

struct AirData: Codable {
    let data: Data
}

struct Data: Codable {
    let city: String
    let state: String
    let country: String
    let current: Current
    
}


struct Current: Codable {
    
    let weather: Weather
    let pollution: Pollution
}

struct Weather: Codable {
    let ic: String
}

struct Pollution: Codable {
    let aqius: Int
}
