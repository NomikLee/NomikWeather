//
//  HourlyWeatherTableViewCell.swift
//  Weather
//
//  Created by Pinocchio on 2024/9/28.
//

import UIKit
import Combine

class HourlyWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "HourlyWeatherTableViewCell"
    
    // MARK: - Variables
    private let viewModel = WeatherDataViewModels()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 150)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        bindView()
        configureUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func bindView() {
        viewModel.fetchWeatherHourlyData()
        viewModel.$hourlyDatas.sink { [weak self] _ in
            self?.collectionView.reloadData()
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
}
// MARK: - Extension
extension HourlyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
        
        let nowTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"                 // 格式為小時
        dateFormatter.timeZone = TimeZone.current       // 目前時區
        let timeString = dateFormatter.string(from: nowTime)
        
        cell.configureHourlyData(to: viewModel.hourlyDatas?.hourly.precipitationProbability[indexPath.row + Int(timeString)!] ?? 0,
                                 hourlyWeatherCode: viewModel.hourlyDatas?.hourly.weatherCode[indexPath.row + Int(timeString)!] ?? 0,
                                 hourTemperature: viewModel.hourlyDatas?.hourly.temperature2m[indexPath.row + Int(timeString)!] ?? 0.0,
                                 hourTime: viewModel.hourlyDatas?.hourly.time[indexPath.row + Int(timeString)!] ?? "")
        cell.backgroundColor = UIColor(red: 38/255, green: 33/255, blue: 69/255, alpha: 1)
        cell.layer.cornerRadius = 15
        return cell

    }
}
