//
//  WeatherDataViewModels.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation
import Combine

class WeatherDataViewModels: ObservableObject {
    @Published var hourlyDatas: HourlyData?
    @Published var currentDatas: CurrentData?
    @Published var dailyDatas: DailyData?
    @Published var currentCityDatas: CurrentData?
    @Published var dailyCityDatas: DailyData?
    
    
    //每小時天氣資料
    func fetchWeatherHourlyData(latitude: String, longitude: String) {
        WeatherDataManerger.shared.fetchHourData(latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.hourlyDatas = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    //首頁目前天氣資料
    func fetchWeatherCurrentData(latitude: String, longitude: String) {
        WeatherDataManerger.shared.fetchCurrentData(latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.currentDatas = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    //每日天氣資料
    func fetchWeatherDailyData(latitude: String, longitude: String) {
        WeatherDataManerger.shared.fetchDailyData(latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.dailyDatas = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //city目前天氣資料
    func fetchWeatherCurrentCityData(latitude: String, longitude: String) {
        WeatherDataManerger.shared.fetchCityCurrentData(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let data):
                self?.currentCityDatas = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //city當天天氣資料
    func fetchWeatherDailyCityData(latitude: String, longitude: String) {
        WeatherDataManerger.shared.fetchCityDailyData(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dailyCityDatas = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

