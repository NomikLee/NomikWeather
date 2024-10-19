//
//  WeatherDataViewModels.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation
import Combine

class WeatherDataViewModels: ObservableObject {
    @Published var weatherData: WeatherData?
    
    func fetchWeatherData() {
        WeatherDataManerger.shared.fetchHourData{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    self?.weatherData = weatherData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

