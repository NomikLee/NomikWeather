//
//  HomeHeaderView.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import UIKit
import Combine

class HomeHeaderView: UIView {
    
    // MARK: - Variables
    private let viewModel = WeatherDataViewModels()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    private let localCityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 45, weight: .semibold)
        label.textColor = .systemOrange
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    private var weatherCurrentTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "--"
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherTemperatureMax: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.text = "高"
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherTemperatureMaxNum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-- °c"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherTemperatureMin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.text = "低"
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherTemperatureMinNum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "-- °c"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(weatherImageView)
        addSubview(weatherCurrentTemperature)
        addSubview(weatherNameLabel)
        addSubview(weatherTemperatureMax)
        addSubview(weatherTemperatureMaxNum)
        addSubview(weatherTemperatureMin)
        addSubview(weatherTemperatureMinNum)
        addSubview(localCityName)
        
        configureUI()
        bindView()
        
        weatherImageView.image = WeatherWmo.noSingle.weatherIconImage
        weatherNameLabel.text = WeatherWmo.noSingle.weatherChinese
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func bindView() {
        LocationManerger.shared.updateLocationNameSubject.sink { [weak self] locationName in
            self?.localCityName.text = "✤ \(locationName) "
        }
        .store(in: &cancellables)
        
        LocationManerger.shared.updateLocationSubject.sink { [weak self] location in
            self?.viewModel.fetchWeatherCurrentData(latitude: location.latitude.description, longitude: location.longitude.description)
            self?.viewModel.fetchWeatherDailyData(latitude: location.latitude.description, longitude: location.longitude.description)
        }
        .store(in: &cancellables)
        
        viewModel.$currentDatas.sink { [weak self] data in
            guard let code = data?.current.weatherCode, let temp = data?.current.temperature2m else { return }
            self?.weatherWmoCheck(code)
            self?.weatherCurrentTemperature.text = "\(Int(round(temp))) °c"
        }
        .store(in: &cancellables)
        
        viewModel.$dailyDatas.sink { [weak self] data in
            guard let tempMax = data?.daily.temperature2mMax.first, let tempMin = data?.daily.temperature2mMin.first else { return }
            self?.weatherTemperatureMaxNum.text = "\(Int(round(tempMax))) °c"
            self?.weatherTemperatureMinNum.text = "\(Int(round(tempMin))) °c"
        }
        .store(in: &cancellables)
        
    }
    
    private func weatherWmoCheck(_ code: Int) {
        switch code {
        case WeatherWmo.clearSky.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.clearSky.weatherIconImage
            weatherNameLabel.text = WeatherWmo.clearSky.weatherChinese
        case WeatherWmo.mainlyClear.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.mainlyClear.weatherIconImage
            weatherNameLabel.text = WeatherWmo.mainlyClear.weatherChinese
        case WeatherWmo.partlyCloudy.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.partlyCloudy.weatherIconImage
            weatherNameLabel.text = WeatherWmo.partlyCloudy.weatherChinese
        case WeatherWmo.Overcast.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.Overcast.weatherIconImage
            weatherNameLabel.text = WeatherWmo.Overcast.weatherChinese
        case WeatherWmo.fog.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.fog.weatherIconImage
            weatherNameLabel.text = WeatherWmo.fog.weatherChinese
        case WeatherWmo.depositingRimeFog.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.depositingRimeFog.weatherIconImage
            weatherNameLabel.text = WeatherWmo.depositingRimeFog.weatherChinese
        case WeatherWmo.drizzleLight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.drizzleLight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.drizzleLight.weatherChinese
        case WeatherWmo.drizzleModerate.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.drizzleModerate.weatherIconImage
            weatherNameLabel.text = WeatherWmo.drizzleModerate.weatherChinese
        case WeatherWmo.drizzleDenseIntensity.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.drizzleDenseIntensity.weatherIconImage
            weatherNameLabel.text = WeatherWmo.drizzleDenseIntensity.weatherChinese
        case WeatherWmo.freezingDrizzleLight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.freezingDrizzleLight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.freezingDrizzleLight.weatherChinese
        case WeatherWmo.freezingDrizzleDenseIntensity.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.freezingDrizzleDenseIntensity.weatherIconImage
            weatherNameLabel.text = WeatherWmo.freezingDrizzleDenseIntensity.weatherChinese
        case WeatherWmo.rainSlight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.rainSlight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.rainSlight.weatherChinese
        case WeatherWmo.rainModerate.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.rainModerate.weatherIconImage
            weatherNameLabel.text = WeatherWmo.rainModerate.weatherChinese
        case WeatherWmo.rainHeavyIntensity.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.rainHeavyIntensity.weatherIconImage
            weatherNameLabel.text = WeatherWmo.rainHeavyIntensity.weatherChinese
        case WeatherWmo.freezingRainLight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.freezingRainLight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.freezingRainLight.weatherChinese
        case WeatherWmo.freezingRainHeavyIntensity.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.freezingRainHeavyIntensity.weatherIconImage
            weatherNameLabel.text = WeatherWmo.freezingRainHeavyIntensity.weatherChinese
        case WeatherWmo.snowFallSlight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.snowFallSlight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.snowFallSlight.weatherChinese
        case WeatherWmo.snowFallModerate.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.snowFallModerate.weatherIconImage
            weatherNameLabel.text = WeatherWmo.snowFallModerate.weatherChinese
        case WeatherWmo.snowFallHeavyIntensity.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.snowFallHeavyIntensity.weatherIconImage
            weatherNameLabel.text = WeatherWmo.snowFallHeavyIntensity.weatherChinese
        case WeatherWmo.snowGrains.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.snowGrains.weatherIconImage
            weatherNameLabel.text = WeatherWmo.snowGrains.weatherChinese
        case WeatherWmo.rainShowersSlight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.rainShowersSlight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.rainShowersSlight.weatherChinese
        case WeatherWmo.rainShowersModerate.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.rainShowersModerate.weatherIconImage
            weatherNameLabel.text = WeatherWmo.rainShowersModerate.weatherChinese
        case WeatherWmo.rainShowersViolent.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.rainShowersViolent.weatherIconImage
            weatherNameLabel.text = WeatherWmo.rainShowersViolent.weatherChinese
        case WeatherWmo.snowShowersSlight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.snowShowersSlight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.snowShowersSlight.weatherChinese
        case WeatherWmo.snowShowersHeavy.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.snowShowersHeavy.weatherIconImage
            weatherNameLabel.text = WeatherWmo.snowShowersHeavy.weatherChinese
        case WeatherWmo.thunderstormSlight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.thunderstormSlight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.thunderstormSlight.weatherChinese
        case WeatherWmo.thunderstormModerate.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.thunderstormModerate.weatherIconImage
            weatherNameLabel.text = WeatherWmo.thunderstormModerate.weatherChinese
        case WeatherWmo.thunderstormWithSlight.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.thunderstormWithSlight.weatherIconImage
            weatherNameLabel.text = WeatherWmo.thunderstormWithSlight.weatherChinese
        case WeatherWmo.thunderstormWithHeavyHail.weatherCodeWMO:
            weatherImageView.image = WeatherWmo.thunderstormWithHeavyHail.weatherIconImage
            weatherNameLabel.text = WeatherWmo.thunderstormWithHeavyHail.weatherChinese
        default:
            weatherImageView.image = WeatherWmo.noSingle.weatherIconImage
            weatherNameLabel.text = WeatherWmo.noSingle.weatherChinese
        }
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            localCityName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            localCityName.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 50),
            weatherImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 270),
            weatherImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),
            
            weatherNameLabel.topAnchor.constraint(equalTo: weatherImageView.topAnchor),
            weatherNameLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
            weatherNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            weatherCurrentTemperature.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            weatherCurrentTemperature.leadingAnchor.constraint(equalTo: weatherImageView.leadingAnchor),
            weatherCurrentTemperature.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherCurrentTemperature.heightAnchor.constraint(equalToConstant: 60),
            
            weatherTemperatureMax.topAnchor.constraint(equalTo: weatherCurrentTemperature.bottomAnchor),
            weatherTemperatureMax.leadingAnchor.constraint(equalTo: weatherCurrentTemperature.leadingAnchor),
            weatherTemperatureMax.widthAnchor.constraint(equalToConstant: 30),
            weatherTemperatureMax.heightAnchor.constraint(equalToConstant: 50),
            
            weatherTemperatureMaxNum.topAnchor.constraint(equalTo: weatherTemperatureMax.topAnchor),
            weatherTemperatureMaxNum.leadingAnchor.constraint(equalTo: weatherTemperatureMax.trailingAnchor),
            weatherTemperatureMaxNum.widthAnchor.constraint(equalToConstant: 50),
            weatherTemperatureMaxNum.heightAnchor.constraint(equalToConstant: 50),
            
            weatherTemperatureMin.topAnchor.constraint(equalTo: weatherTemperatureMax.topAnchor),
            weatherTemperatureMin.leadingAnchor.constraint(equalTo: weatherTemperatureMaxNum.trailingAnchor),
            weatherTemperatureMin.widthAnchor.constraint(equalToConstant: 30),
            weatherTemperatureMin.heightAnchor.constraint(equalToConstant: 50),
            
            weatherTemperatureMinNum.topAnchor.constraint(equalTo: weatherTemperatureMin.topAnchor),
            weatherTemperatureMinNum.leadingAnchor.constraint(equalTo: weatherTemperatureMin.trailingAnchor),
            weatherTemperatureMinNum.widthAnchor.constraint(equalToConstant: 50),
            weatherTemperatureMinNum.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
// MARK: - Extension
