//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Pinocchio on 2024/11/6.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    static let identifier = "CityTableViewCell"
    
    // MARK: - Variables
    // MARK: - UI Components
    private let cityWeatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "cloud.rain.fill")
        imageView.tintColor = .systemOrange
        return imageView
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "那瑪夏區"
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let cityWeatherName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "多雲時晴"
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let cityWeatherTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-25°"
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let cityWeatherHighTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "36°"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemRed
        return label
    }()
    
    private let cityWeatherLowTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-30°"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemMint
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemIndigo
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(cityWeatherIcon)
        contentView.addSubview(cityName)
        contentView.addSubview(cityWeatherName)
        contentView.addSubview(cityWeatherTemp)
        contentView.addSubview(cityWeatherHighTemp)
        contentView.addSubview(cityWeatherLowTemp)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func configureCityData(code: Int, name: String, Temp: Double, highTemp: Double, lowTemp: Double) {
        cityIconCheck(cityWeatherCode: code)
        cityName.text = "\(name)"
        cityWeatherTemp.text = "\(Temp)"
        cityWeatherHighTemp.text = "\(highTemp)"
        cityWeatherLowTemp.text = "\(lowTemp)"
    }
    
    //天氣icon判斷
    private func cityIconCheck(cityWeatherCode: Int) {
        switch cityWeatherCode {
        case WeatherWmo.clearSky.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.clearSky.weatherIconImage
            cityWeatherName.text = WeatherWmo.clearSky.weatherChinese
        case WeatherWmo.mainlyClear.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.mainlyClear.weatherIconImage
            cityWeatherName.text = WeatherWmo.mainlyClear.weatherChinese
        case WeatherWmo.partlyCloudy.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.partlyCloudy.weatherIconImage
            cityWeatherName.text = WeatherWmo.partlyCloudy.weatherChinese
        case WeatherWmo.Overcast.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.Overcast.weatherIconImage
            cityWeatherName.text = WeatherWmo.Overcast.weatherChinese
        case WeatherWmo.fog.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.fog.weatherIconImage
            cityWeatherName.text = WeatherWmo.fog.weatherChinese
        case WeatherWmo.depositingRimeFog.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.depositingRimeFog.weatherIconImage
            cityWeatherName.text = WeatherWmo.depositingRimeFog.weatherChinese
        case WeatherWmo.drizzleLight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.drizzleLight.weatherIconImage
            cityWeatherName.text = WeatherWmo.drizzleLight.weatherChinese
        case WeatherWmo.drizzleModerate.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.drizzleModerate.weatherIconImage
            cityWeatherName.text = WeatherWmo.drizzleModerate.weatherChinese
        case WeatherWmo.drizzleDenseIntensity.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.drizzleDenseIntensity.weatherIconImage
            cityWeatherName.text = WeatherWmo.drizzleDenseIntensity.weatherChinese
        case WeatherWmo.freezingDrizzleLight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.freezingDrizzleLight.weatherIconImage
            cityWeatherName.text = WeatherWmo.freezingDrizzleLight.weatherChinese
        case WeatherWmo.freezingDrizzleDenseIntensity.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.freezingDrizzleDenseIntensity.weatherIconImage
            cityWeatherName.text = WeatherWmo.freezingDrizzleDenseIntensity.weatherChinese
        case WeatherWmo.rainSlight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.rainSlight.weatherIconImage
            cityWeatherName.text = WeatherWmo.rainSlight.weatherChinese
        case WeatherWmo.rainModerate.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.rainModerate.weatherIconImage
            cityWeatherName.text = WeatherWmo.rainModerate.weatherChinese
        case WeatherWmo.rainHeavyIntensity.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.rainHeavyIntensity.weatherIconImage
            cityWeatherName.text = WeatherWmo.rainHeavyIntensity.weatherChinese
        case WeatherWmo.freezingRainLight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.freezingRainLight.weatherIconImage
            cityWeatherName.text = WeatherWmo.freezingRainLight.weatherChinese
        case WeatherWmo.freezingRainHeavyIntensity.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.freezingRainHeavyIntensity.weatherIconImage
            cityWeatherName.text = WeatherWmo.freezingRainHeavyIntensity.weatherChinese
        case WeatherWmo.snowFallSlight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.snowFallSlight.weatherIconImage
            cityWeatherName.text = WeatherWmo.snowFallSlight.weatherChinese
        case WeatherWmo.snowFallModerate.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.snowFallModerate.weatherIconImage
            cityWeatherName.text = WeatherWmo.snowFallModerate.weatherChinese
        case WeatherWmo.snowFallHeavyIntensity.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.snowFallHeavyIntensity.weatherIconImage
            cityWeatherName.text = WeatherWmo.snowFallHeavyIntensity.weatherChinese
        case WeatherWmo.snowGrains.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.snowGrains.weatherIconImage
            cityWeatherName.text = WeatherWmo.snowGrains.weatherChinese
        case WeatherWmo.rainShowersSlight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.rainShowersSlight.weatherIconImage
            cityWeatherName.text = WeatherWmo.rainShowersSlight.weatherChinese
        case WeatherWmo.rainShowersModerate.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.rainShowersModerate.weatherIconImage
            cityWeatherName.text = WeatherWmo.rainShowersModerate.weatherChinese
        case WeatherWmo.rainShowersViolent.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.rainShowersViolent.weatherIconImage
            cityWeatherName.text = WeatherWmo.rainShowersViolent.weatherChinese
        case WeatherWmo.snowShowersSlight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.snowShowersSlight.weatherIconImage
            cityWeatherName.text = WeatherWmo.snowShowersSlight.weatherChinese
        case WeatherWmo.snowShowersHeavy.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.snowShowersHeavy.weatherIconImage
            cityWeatherName.text = WeatherWmo.snowShowersHeavy.weatherChinese
        case WeatherWmo.thunderstormSlight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.thunderstormSlight.weatherIconImage
            cityWeatherName.text = WeatherWmo.thunderstormSlight.weatherChinese
        case WeatherWmo.thunderstormModerate.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.thunderstormModerate.weatherIconImage
            cityWeatherName.text = WeatherWmo.thunderstormModerate.weatherChinese
        case WeatherWmo.thunderstormWithSlight.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.thunderstormWithSlight.weatherIconImage
            cityWeatherName.text = WeatherWmo.thunderstormWithSlight.weatherChinese
        case WeatherWmo.thunderstormWithHeavyHail.weatherCodeWMO:
            cityWeatherIcon.image = WeatherWmo.thunderstormWithHeavyHail.weatherIconImage
            cityWeatherName.text = WeatherWmo.thunderstormWithHeavyHail.weatherChinese
        default:
            cityWeatherIcon.image = WeatherWmo.noSingle.weatherIconImage
            cityWeatherName.text = WeatherWmo.noSingle.weatherChinese
        }
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            cityWeatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityWeatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cityWeatherIcon.widthAnchor.constraint(equalToConstant: 90),
            cityWeatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
            
            cityName.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityName.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityName.leadingAnchor.constraint(equalTo: cityWeatherIcon.trailingAnchor),
            cityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            cityWeatherName.topAnchor.constraint(equalTo: cityName.bottomAnchor),
            cityWeatherName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cityWeatherName.leadingAnchor.constraint(equalTo: cityName.leadingAnchor),
            cityWeatherName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            cityWeatherTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cityWeatherTemp.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityWeatherTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cityWeatherTemp.widthAnchor.constraint(equalToConstant: 120),
            
            cityWeatherHighTemp.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityWeatherHighTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cityWeatherHighTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cityWeatherHighTemp.widthAnchor.constraint(equalToConstant: 50),
            
            cityWeatherLowTemp.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityWeatherLowTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cityWeatherLowTemp.leadingAnchor.constraint(equalTo: cityWeatherHighTemp.trailingAnchor),
            cityWeatherLowTemp.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}
// MARK: - Extension
