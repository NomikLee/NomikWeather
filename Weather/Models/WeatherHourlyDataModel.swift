//
//  WeatherHourlyDataModel.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation

struct HourlyData: Codable {
    let latitude: Double
    let longitude: Double
    let hourly: Hourly
}

struct Hourly: Codable {
    let time: [String]
    let temperature2m: [Double]
    let relativeHumidity2m: [Int]
    let precipitationProbability: [Int]
    let precipitation: [Double]
    let weatherCode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
        case precipitationProbability = "precipitation_probability"
        case precipitation
        case weatherCode = "weather_code"
    }
}
