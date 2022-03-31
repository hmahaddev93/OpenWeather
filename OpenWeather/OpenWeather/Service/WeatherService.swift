//
//  WeatherService.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import Foundation
import Combine

enum WeatherAPI  {
    static let host: String = "api.openweathermap.org"
    static let appId: String = "8d989c54d903eb59eb6306490bc22199"
    enum EndPoints {
        static let weather = "/data/2.5/weather"
    }
    static let imageUrlFormat = "https://openweathermap.org/img/wn/%@@2x.png"
}

protocol WeatherService_Protocol {
    func weather(by city: String, completion: @escaping (Result<CityWeatherResponse, Error>) -> Void)
    func weatherIcon(with iconId: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class WeatherService: WeatherService_Protocol {

    static let shared: WeatherService = WeatherService()
    private var cancellable: AnyCancellable?
    private let jsonDecoder: JSONDecoder
    
    init() {
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    enum WeatherServiceError: Error {
        case invalidUrl
        case emptyWeather
    }
    
    func weather(by city: String, completion: @escaping (Result<CityWeatherResponse, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = WeatherAPI.host
        urlComponents.path = WeatherAPI.EndPoints.weather
        let queryItemAppId = URLQueryItem(name: "appid", value: WeatherAPI.appId)
        let queryItemCity = URLQueryItem(name: "q", value: city)
        urlComponents.queryItems = [queryItemCity, queryItemAppId]
        
        guard let url = urlComponents.url else {
            completion(.failure(WeatherServiceError.invalidUrl))
            return
        }
        
        self.cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .decode(type: CityWeatherResponse.self, decoder: self.jsonDecoder)
            .sink(receiveCompletion: { complete in
                switch complete {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            },receiveValue: { weatherResponse in
                guard weatherResponse.weather?.first != nil else {
                    completion(.failure(WeatherServiceError.emptyWeather))
                    return
                }
                completion(.success(weatherResponse))
            })
    }
    
    func weatherIcon(with iconId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: String(format: WeatherAPI.imageUrlFormat, iconId))!

        self.cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .sink(receiveCompletion: { complete in
                switch complete {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            },receiveValue: { data in
                completion(.success(data))
            })
    }

}
