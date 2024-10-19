//
//  WeatherDataModels.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let hourly: HourlyData
}

struct HourlyData: Codable {
    let time: [String]
    let temperature2M: [Double]
    let relativeHumidity2M: [Int]
    let precipitationProbability: [Int]
    let precipitation: [Double]
    let weatherCode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case precipitationProbability = "precipitation_probability"
        case precipitation
        case weatherCode = "weather_code"
    }
}
