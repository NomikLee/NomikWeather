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
    func fetchCurrentData(latitude: String, longitude: String, completion: @escaping (Result<CurrentData, Error>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,is_day,precipitation,weather_code"),
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
    func fetchHourData(latitude: String, longitude: String, completion: @escaping(Result<HourlyData, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "hourly", value: "temperature_2m,relative_humidity_2m,precipitation_probability,precipitation,weather_code"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "2")
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
    func fetchDailyData(latitude: String, longitude: String, completion: @escaping (Result<DailyData, Error>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max"),
            URLQueryItem(name: "forecast_days", value: "14"),
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
    
    //取得City目前天氣資料
    func fetchCityCurrentData(latitude: String, longitude: String, completion: @escaping (Result<CurrentData, Error>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,is_day,precipitation,weather_code"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "1")
        ]
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        
        let request = URLRequest(url: url)
        
        let tast = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let cityCurrentDatas = try JSONDecoder().decode(CurrentData.self, from: data)
                completion(.success(cityCurrentDatas))
            } catch {
                completion(.failure(error))
            }
        }
        tast.resume()
    }
    
    //取得City每日天氣資料
    func fetchCityDailyData(latitude: String, longitude: String, completion: @escaping (Result<DailyData, Error>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max"),
            URLQueryItem(name: "forecast_days", value: "14"),
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
