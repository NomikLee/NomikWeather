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
