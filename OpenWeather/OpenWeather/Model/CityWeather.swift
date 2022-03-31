//
//  CityWeather.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import Foundation

struct CityWeatherResponse: Codable {
    let cod: Int
    let name: String?
    let message: String?
    let weather: [Weather]?
    let temperature: Temperature?
    
    enum CodingKeys: String, CodingKey {
        case cod
        case name
        case message
        case weather
        case temperature = "main"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temperature: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
}
