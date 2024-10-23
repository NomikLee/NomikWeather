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
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.text = "高"
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherTemperatureMaxNum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "27 °c"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherTemperatureMin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .systemBlue
        label.text = "低"
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherTemperatureMinNum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "-18 °c"
        label.font = .systemFont(ofSize: 34, weight: .bold)
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
        viewModel.fetchWeatherCurrentData()
        viewModel.$currentDatas.sink { [weak self] data in
            guard let code = data?.current.weatherCode, let tempOptional = data?.current.temperature2m else { return }
            var temp = tempOptional
            self?.weatherWmoCheck(code)
            self?.weatherCurrentTemperature.text = "\(Int(round(temp))) °c"
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
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            weatherImageView.widthAnchor.constraint(equalToConstant: 200),
            weatherImageView.heightAnchor.constraint(equalToConstant: 150),
            
            weatherCurrentTemperature.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            weatherCurrentTemperature.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherCurrentTemperature.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherCurrentTemperature.heightAnchor.constraint(equalToConstant: 50),
            
            weatherNameLabel.topAnchor.constraint(equalTo: weatherCurrentTemperature.bottomAnchor),
            weatherNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            weatherTemperatureMaxNum.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor),
            weatherTemperatureMaxNum.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            weatherTemperatureMaxNum.widthAnchor.constraint(equalToConstant: 100),
            weatherTemperatureMaxNum.heightAnchor.constraint(equalToConstant: 100),
            
            weatherTemperatureMax.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor),
            weatherTemperatureMax.trailingAnchor.constraint(equalTo: weatherTemperatureMaxNum.leadingAnchor),
            weatherTemperatureMax.widthAnchor.constraint(equalToConstant: 30),
            weatherTemperatureMax.heightAnchor.constraint(equalToConstant: 100),
            
            weatherTemperatureMin.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor),
            weatherTemperatureMin.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            weatherTemperatureMin.widthAnchor.constraint(equalToConstant: 30),
            weatherTemperatureMin.heightAnchor.constraint(equalToConstant: 100),
            
            weatherTemperatureMinNum.topAnchor.constraint(equalTo: weatherNameLabel.bottomAnchor),
            weatherTemperatureMinNum.leadingAnchor.constraint(equalTo: weatherTemperatureMin.trailingAnchor),
            weatherTemperatureMinNum.widthAnchor.constraint(equalToConstant: 100),
            weatherTemperatureMinNum.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
// MARK: - Extension
