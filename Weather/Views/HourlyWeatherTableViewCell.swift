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
        layout.itemSize = CGSize(width: 80, height: 130)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        
        bindView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
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
}
// MARK: - Extension
extension HourlyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
        cell.configureHourlyData(to: viewModel.hourlyDatas?.hourly.precipitationProbability[indexPath.row] ?? 0,
                                 hourlyWeatherCode: viewModel.hourlyDatas?.hourly.weatherCode[indexPath.row] ?? 0,
                                 hourTemperature: viewModel.hourlyDatas?.hourly.temperature2m[indexPath.row] ?? 0.0,
                                 hourTime: viewModel.hourlyDatas?.hourly.time[indexPath.row] ?? "")
        cell.backgroundColor = .systemPink
        cell.layer.cornerRadius = 10
        return cell
    }
}
