//
//  WeatherDataManerger.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import Foundation

struct WeatherDataManerger {
    
    static let shared = WeatherDataManerger()
    
    //取得小時的資料
    func fetchHourData(completion: @escaping(Result<WeatherData, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: APIConstants.baseURL)
        
        let queryItems = [
            URLQueryItem(name: "latitude", value: "25.048532613524102"),
            URLQueryItem(name: "longitude", value: "121.45355426600807"),
            URLQueryItem(name: "hourly", value: "temperature_2m,relative_humidity_2m,precipitation_probability,precipitation,weather_code")
        ]
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                let weatherHourDatas = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherHourDatas))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
