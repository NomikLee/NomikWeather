//
//  WeatherDataManerger.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation

struct WeatherDataManerger {
    
    static let shared = WeatherDataManerger()
    
    //取得目前天氣的資料
    func fetchCurrentData(completion: @escaping (Result<CurrentData, Error>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: "25.048532613524102"),
            URLQueryItem(name: "longitude", value: "121.45355426600807"),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,precipitation,weather_code"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "1")
        ]
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let weatherCurrentDatas = try JSONDecoder().decode(CurrentData.self, from: data)
                completion(.success(weatherCurrentDatas))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    //取得小時天氣的資料
    func fetchHourData(completion: @escaping(Result<HourlyData, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: "25.048532613524102"),
            URLQueryItem(name: "longitude", value: "121.45355426600807"),
            URLQueryItem(name: "hourly", value: "temperature_2m,relative_humidity_2m,precipitation_probability,precipitation,weather_code"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "1")
        ]
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                let weatherHourDatas = try JSONDecoder().decode(HourlyData.self, from: data)
                completion(.success(weatherHourDatas))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    //取得每日天氣資料
    func fecthdDailyData(completion: @escaping (Result<DailyData, Error>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: "25.048532613524102"),
            URLQueryItem(name: "longitude", value: "121.45355426600807"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max"),
            URLQueryItem(name: "timezone", value: "auto")
        ]
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        let tast = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let dailyDatas = try JSONDecoder().decode(DailyData.self, from: data)
                completion(.success(dailyDatas))
            } catch {
                completion(.failure(error))
            }
        }
        tast.resume()
    }
}
