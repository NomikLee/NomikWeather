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
    
    //每小時天氣資料
    func fetchWeatherHourlyData() {
        WeatherDataManerger.shared.fetchHourData{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let hourlyData):
                    self?.hourlyDatas = hourlyData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //當下天氣資料
    func fetchWeatherCurrentData() {
        WeatherDataManerger.shared.fetchCurrentData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let currentData):
                    self?.currentDatas = currentData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //每日天氣資料
    func fetchWeatherDailyData() {
        WeatherDataManerger.shared.fecthdDailyData { [weak self] result in
            switch result {
            case .success(let dailyData):
                self?.dailyDatas = dailyData
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

