//
//  LocationManerger.swift
//  Weather
//
//  Created by Pinocchio on 2024/11/6.
//

import Foundation
import CoreLocation
import Combine

class LocationManerger: NSObject {
    
    static let shared = LocationManerger()
    
    var updateLocationSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    var updateLocationNameSubject = PassthroughSubject<String, Never>()
    
    lazy var locationManerger: CLLocationManager = {
        let location = CLLocationManager()
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        location.delegate = self
        return location
    }()
    
    private override init() {
        super.init()
        requestLocation()
    }
    
    //檢查處理Location的授權狀態
    func requestLocation() {
        switch locationManerger.authorizationStatus {
        case .notDetermined: //尚未選擇是否可以使用Location服務時使用
            locationManerger.requestWhenInUseAuthorization()
        case .restricted: //無權使用定位服務時使用
            locationManerger.requestWhenInUseAuthorization()
        case .denied: //使用者拒絕位置服務時使用
            print("已拒絕使用位置服務")
        case .authorizedAlways: //使用者授權隨時啟動定位服務
            locationManerger.startUpdatingLocation()
        case .authorizedWhenInUse: //使用者授權在使用app中啟動定位服務
            locationManerger.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
}
extension LocationManerger: CLLocationManagerDelegate {
    //權限更動時會自動調用
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocation()
    }
    
    //當Location成功更新位置時觸發
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationCoordinate = locations.last?.coordinate, let location = locations.last else { return }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let placemark = placemarks?.first {
                    let city = placemark.locality
                    self.updateLocationNameSubject.send(city ?? "無地點")
                }
            }
        locationManerger.stopUpdatingLocation()
        updateLocationSubject.send(locationCoordinate)
    }
    
    //當Location失敗時觸發error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
