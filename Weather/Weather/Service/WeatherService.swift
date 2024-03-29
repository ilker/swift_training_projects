//
//  WeatherService.swift
//  Weather
//
//  Created by ILKER on 13.06.2023.
//

import Foundation
import CoreLocation

enum ServiceError: String, Error {
case serverError = "Check your network connection!"
case decodingError = "Decoding Error!"
}

struct WeatherService {
    let url = "https://api.openweathermap.org/data/2.5/weather?&appid=b76bcaba7a3be2b8494b366c98efadc4&units=metric"
        
    func fetchWeatherCityName(forCityName cityName: String, completion: @escaping(Result<WeatherModel,ServiceError>) -> Void) {
        if let url = URL(string: "\(url)&q=\(cityName)") {
            fetchWeather(url: url, completion: completion)
        }
        
    }
    func fetchWeatherLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping(Result<WeatherModel,ServiceError>) -> Void) {
        let url = URL(string: "\(url)&lat=\(latitude)&lon=\(longitude)")!
        fetchWeather(url: url, completion: completion)
    }
    private func fetchWeather(url: URL, completion: @escaping(Result<WeatherModel,ServiceError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                guard let data = data else { return }
                guard let result = parseJSON(data: data) else {
                    completion(.failure(.decodingError))
                    return
                }
                completion(.success(result))
            }
        }.resume()
    }
    private func parseJSON(data: Data) -> WeatherModel? {
        do {
            let result = try JSONDecoder().decode(WeatherModel.self, from: data)
            return result
        } catch {
            return nil
        }
    }
}

