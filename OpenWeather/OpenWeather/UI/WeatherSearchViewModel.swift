//
//  WeatherSearchViewModel.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import Foundation

class WeatherSearchViewModel {
    // MARK: - Initialization
    init(model: [CityWeatherResponse]? = nil) {
        if let inputModel = model {
            cityWeather = inputModel
        }
    }
    var cityWeather = [CityWeatherResponse]()
    let title = "City Weather"
}

extension WeatherSearchViewModel {
    func searchWeather(by city: String, completion: @escaping (Result<CityWeatherResponse, Error>) -> Void) {
        
        WeatherService.shared.weather(by: city) { result in
            switch result {
                
            case .success(let cityWeather):
                completion(.success(cityWeather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

