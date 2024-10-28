//
//  WeatherCurrentDataModel.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation

struct CurrentData: Codable {
    let latitude: Double
    let longitude: Double
    let current: Current
}

struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2m: Double
    let relativeHumidity2m: Double
    let isDay: Int
    let precipitation: Double
    let weatherCode: Int
    
    enum CodingKeys: String, CodingKey {
        case time
        case interval
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
        case isDay = "is_day"
        case precipitation
        case weatherCode = "weather_code"
    }
}
