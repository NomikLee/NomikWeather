//
//  DailyWeatherTableViewCell.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/26.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    static let identifier = "DailyWeatherTableViewCell"
    
    // MARK: - Variables
    // MARK: - UI Components
    private let dateDailyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let dateDailyIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "sun.min.fill")
        imageView.tintColor = .systemOrange
        return imageView
    }()
    
    private let dateDailyProbability: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "--%"
        label.textAlignment = .center
        return label
    }()
    
    private let dateDailyPrecipitationSum: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.25
        progressView.trackTintColor = .black
        progressView.progressTintColor = .systemBlue
        return progressView
    }()
    
    private let dateDailyPrecipitationSumLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "--- mm"
        label.textAlignment = .left
        return label
    }()
    
    private let dateDailyMaxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "--°"
        label.textColor = .systemRed
        label.textAlignment = .left
        return label
    }()
    
    private let dateDailyMinTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "--°"
        label.textColor = .systemBlue
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray5
        contentView.alpha = 0.7
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(dateDailyLabel)
        contentView.addSubview(dateDailyIcon)
        contentView.addSubview(dateDailyProbability)
        contentView.addSubview(dateDailyPrecipitationSum)
        dateDailyPrecipitationSum.addSubview(dateDailyPrecipitationSumLabel)
        contentView.addSubview(dateDailyMaxTemp)
        contentView.addSubview(dateDailyMinTemp)
        
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func configureDailyData(to dateDaily: String, dailyCode: Int, dailyProbability: Int, dailyPrecipitationSum: Double, dailyMaxTemp: Double, dailyMinTemp: Double) {
        guard let formatterWeekDate = formatterWeek(from: dateDaily) else { return }
        dateDailyLabel.text = "週\(formatterWeekDate)"
        dateDailyIconCheck(dailyWeatherCode: dailyCode)
        dateDailyProbability.text = "\(dailyProbability)%"
        dateDailyPrecipitationSumLabel.text = "\(dailyPrecipitationSum) mm"
        dateDailyPrecipitationSum.progress = precipitationSumBar(precipitationSum: dailyPrecipitationSum)
        dateDailyMaxTemp.text = "\(Int(round(dailyMaxTemp)))°"
        dateDailyMinTemp.text = "\(Int(round(dailyMinTemp)))°"
        
    }
    
    private func precipitationSumBar(precipitationSum: Double) -> Float {
        guard let precipitationSumBar = Float(String(format: "%.2f", precipitationSum / 300)) else {
            return 0.0
        }
        switch precipitationSumBar {
        case 0.0...0.25:
            dateDailyPrecipitationSum.progressTintColor = .systemBlue
        case 0.25...0.5:
            dateDailyPrecipitationSum.progressTintColor = .systemGreen
        case 0.5...0.75:
            dateDailyPrecipitationSum.progressTintColor = .systemRed
        default:
            dateDailyPrecipitationSum.progressTintColor = .systemPurple
        }
        
        return precipitationSumBar
    }
    
    //天氣icon判斷
    private func dateDailyIconCheck(dailyWeatherCode: Int) {
        switch dailyWeatherCode {
        case WeatherWmo.clearSky.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.clearSky.weatherIconImage
        case WeatherWmo.mainlyClear.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.mainlyClear.weatherIconImage
        case WeatherWmo.partlyCloudy.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.partlyCloudy.weatherIconImage
        case WeatherWmo.Overcast.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.Overcast.weatherIconImage
        case WeatherWmo.fog.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.fog.weatherIconImage
        case WeatherWmo.depositingRimeFog.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.depositingRimeFog.weatherIconImage
        case WeatherWmo.drizzleLight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.drizzleLight.weatherIconImage
        case WeatherWmo.drizzleModerate.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.drizzleModerate.weatherIconImage
        case WeatherWmo.drizzleDenseIntensity.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.drizzleDenseIntensity.weatherIconImage
        case WeatherWmo.freezingDrizzleLight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.freezingDrizzleLight.weatherIconImage
        case WeatherWmo.freezingDrizzleDenseIntensity.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.freezingDrizzleDenseIntensity.weatherIconImage
        case WeatherWmo.rainSlight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.rainSlight.weatherIconImage
        case WeatherWmo.rainModerate.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.rainModerate.weatherIconImage
        case WeatherWmo.rainHeavyIntensity.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.rainHeavyIntensity.weatherIconImage
        case WeatherWmo.freezingRainLight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.freezingRainLight.weatherIconImage
        case WeatherWmo.freezingRainHeavyIntensity.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.freezingRainHeavyIntensity.weatherIconImage
        case WeatherWmo.snowFallSlight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.snowFallSlight.weatherIconImage
        case WeatherWmo.snowFallModerate.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.snowFallModerate.weatherIconImage
        case WeatherWmo.snowFallHeavyIntensity.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.snowFallHeavyIntensity.weatherIconImage
        case WeatherWmo.snowGrains.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.snowGrains.weatherIconImage
        case WeatherWmo.rainShowersSlight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.rainShowersSlight.weatherIconImage
        case WeatherWmo.rainShowersModerate.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.rainShowersModerate.weatherIconImage
        case WeatherWmo.rainShowersViolent.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.rainShowersViolent.weatherIconImage
        case WeatherWmo.snowShowersSlight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.snowShowersSlight.weatherIconImage
        case WeatherWmo.snowShowersHeavy.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.snowShowersHeavy.weatherIconImage
        case WeatherWmo.thunderstormSlight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.thunderstormSlight.weatherIconImage
        case WeatherWmo.thunderstormModerate.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.thunderstormModerate.weatherIconImage
        case WeatherWmo.thunderstormWithSlight.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.thunderstormWithSlight.weatherIconImage
        case WeatherWmo.thunderstormWithHeavyHail.weatherCodeWMO:
            dateDailyIcon.image = WeatherWmo.thunderstormWithHeavyHail.weatherIconImage
        default:
            dateDailyIcon.image = WeatherWmo.noSingle.weatherIconImage
        }
    }
    
    //把日期轉成星期
    private func formatterWeek(from dateString: String) -> String.SubSequence? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 日期格式進行解析
        dateFormatter.locale = Locale(identifier: "zh_Hant") // 設定繁體中文

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "EEEE" // "EEEE" 顯示完整的星期名稱
            let dataSplit = dateFormatter.string(from: date)
            return dataSplit.split(separator: "星期").last //切割星期部分只能數字字串
        }
        return nil
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            dateDailyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateDailyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dateDailyLabel.widthAnchor.constraint(equalToConstant: 50),
            dateDailyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dateDailyIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateDailyIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateDailyIcon.leadingAnchor.constraint(equalTo: dateDailyLabel.trailingAnchor, constant: 10),
            dateDailyIcon.widthAnchor.constraint(equalToConstant: 50),
            
            dateDailyProbability.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateDailyProbability.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateDailyProbability.leadingAnchor.constraint(equalTo: dateDailyIcon.trailingAnchor, constant: 10),
            dateDailyProbability.widthAnchor.constraint(equalToConstant: 60),
            
            dateDailyPrecipitationSum.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateDailyPrecipitationSum.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            dateDailyPrecipitationSum.leadingAnchor.constraint(equalTo: dateDailyProbability.trailingAnchor, constant: 10),
            dateDailyPrecipitationSum.trailingAnchor.constraint(equalTo: dateDailyMaxTemp.leadingAnchor, constant: -10),
            
            dateDailyPrecipitationSumLabel.topAnchor.constraint(equalTo: dateDailyPrecipitationSum.topAnchor),
            dateDailyPrecipitationSumLabel.bottomAnchor.constraint(equalTo: dateDailyPrecipitationSum.bottomAnchor),
            dateDailyPrecipitationSumLabel.leadingAnchor.constraint(equalTo: dateDailyPrecipitationSum.leadingAnchor),
            dateDailyPrecipitationSumLabel.trailingAnchor.constraint(equalTo: dateDailyPrecipitationSum.trailingAnchor),
            
            dateDailyMaxTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            dateDailyMaxTemp.bottomAnchor.constraint(equalTo: dateDailyMinTemp.topAnchor),
            dateDailyMaxTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateDailyMaxTemp.widthAnchor.constraint(equalToConstant: 60),
            
            dateDailyMinTemp.topAnchor.constraint(equalTo: dateDailyMaxTemp.bottomAnchor),
            dateDailyMinTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateDailyMinTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dateDailyMinTemp.widthAnchor.constraint(equalToConstant: 60),
            
        ])
    }
}
// MARK: - Extension

