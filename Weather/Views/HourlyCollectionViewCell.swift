//
//  HourlyCollectionViewCell.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/25.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyCollectionViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let rainProbability: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let hourlyWeatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let hourTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let hourTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(rainProbability)
        contentView.addSubview(hourlyWeatherIcon)
        contentView.addSubview(hourTemperatureLabel)
        contentView.addSubview(hourTimeLabel)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func configureHourlyData(to probability: Int, hourlyWeatherCode: Int, hourTemperature: Double, hourTime: String) {
        rainProbability.text = "\(probability)%"
        hourlyWeatherIconCheck(hourlyWeatherCode: hourlyWeatherCode)
        hourTemperatureLabel.text = "\(Int(round(hourTemperature)))"
        guard let hourTimeSplit = hourTime.split(separator: "T").last else { return }
        hourTimeLabel.text = "\(hourTimeSplit)"
    }
    
    private func hourlyWeatherIconCheck(hourlyWeatherCode: Int) {
        switch hourlyWeatherCode {
        case WeatherWmo.clearSky.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.clearSky.weatherIconImage
        case WeatherWmo.mainlyClear.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.mainlyClear.weatherIconImage
        case WeatherWmo.partlyCloudy.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.partlyCloudy.weatherIconImage
        case WeatherWmo.Overcast.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.Overcast.weatherIconImage
        case WeatherWmo.fog.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.fog.weatherIconImage
        case WeatherWmo.depositingRimeFog.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.depositingRimeFog.weatherIconImage
        case WeatherWmo.drizzleLight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.drizzleLight.weatherIconImage
        case WeatherWmo.drizzleModerate.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.drizzleModerate.weatherIconImage
        case WeatherWmo.drizzleDenseIntensity.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.drizzleDenseIntensity.weatherIconImage
        case WeatherWmo.freezingDrizzleLight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.freezingDrizzleLight.weatherIconImage
        case WeatherWmo.freezingDrizzleDenseIntensity.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.freezingDrizzleDenseIntensity.weatherIconImage
        case WeatherWmo.rainSlight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.rainSlight.weatherIconImage
        case WeatherWmo.rainModerate.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.rainModerate.weatherIconImage
        case WeatherWmo.rainHeavyIntensity.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.rainHeavyIntensity.weatherIconImage
        case WeatherWmo.freezingRainLight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.freezingRainLight.weatherIconImage
        case WeatherWmo.freezingRainHeavyIntensity.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.freezingRainHeavyIntensity.weatherIconImage
        case WeatherWmo.snowFallSlight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.snowFallSlight.weatherIconImage
        case WeatherWmo.snowFallModerate.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.snowFallModerate.weatherIconImage
        case WeatherWmo.snowFallHeavyIntensity.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.snowFallHeavyIntensity.weatherIconImage
        case WeatherWmo.snowGrains.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.snowGrains.weatherIconImage
        case WeatherWmo.rainShowersSlight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.rainShowersSlight.weatherIconImage
        case WeatherWmo.rainShowersModerate.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.rainShowersModerate.weatherIconImage
        case WeatherWmo.rainShowersViolent.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.rainShowersViolent.weatherIconImage
        case WeatherWmo.snowShowersSlight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.snowShowersSlight.weatherIconImage
        case WeatherWmo.snowShowersHeavy.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.snowShowersHeavy.weatherIconImage
        case WeatherWmo.thunderstormSlight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.thunderstormSlight.weatherIconImage
        case WeatherWmo.thunderstormModerate.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.thunderstormModerate.weatherIconImage
        case WeatherWmo.thunderstormWithSlight.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.thunderstormWithSlight.weatherIconImage
        case WeatherWmo.thunderstormWithHeavyHail.weatherCodeWMO:
            hourlyWeatherIcon.image = WeatherWmo.thunderstormWithHeavyHail.weatherIconImage
        default:
            hourlyWeatherIcon.image = WeatherWmo.noSingle.weatherIconImage
        }
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            rainProbability.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rainProbability.topAnchor.constraint(equalTo: contentView.topAnchor),
            rainProbability.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rainProbability.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rainProbability.heightAnchor.constraint(equalToConstant: 30),
            
            hourlyWeatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourlyWeatherIcon.topAnchor.constraint(equalTo: rainProbability.bottomAnchor),
            hourlyWeatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourlyWeatherIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourlyWeatherIcon.heightAnchor.constraint(equalToConstant: 30),
            
            hourTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourTemperatureLabel.topAnchor.constraint(equalTo: hourlyWeatherIcon.bottomAnchor, constant: 10),
            hourTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourTemperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            
            hourTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourTimeLabel.topAnchor.constraint(equalTo: hourTemperatureLabel.bottomAnchor),
            hourTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourTimeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
// MARK: - Extension
