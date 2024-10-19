//
//  MainWeatherViewController.swift
//  Weather
//
//  Created by Pinocchio on 2024/9/26.
//

import UIKit
import Combine

class MainWeatherViewController: UIViewController {
    
    private var viewModel = WeatherDataViewModels()
    var cancellables: Set<AnyCancellable> = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainWeatherTableViewCell.self , forCellReuseIdentifier: MainWeatherTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchWeatherData()
        viewModel.$weatherData.sink { [weak self] Result in
            print(Result?.hourly.weatherCode)
        }
        .store(in: &cancellables)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainWeatherTableViewCell.identifier, for: indexPath) as? MainWeatherTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .systemRed
        return cell
    }
    
    
}

