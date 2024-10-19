//
//  WeatherDailyDataModel.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation

struct DailyData: Codable {
    let latitude: Double
    let longitude: Double
    let daily: Daily
}

struct Daily: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    let precipitationSum: [Double]
    let precipitationProbabilityMax: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
        case precipitationSum = "precipitation_sum"
        case precipitationProbabilityMax = "precipitation_probability_max"
    }
}
