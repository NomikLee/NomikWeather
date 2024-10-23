//
//  MainWeatherViewController.swift
//  Weather
//
//  Created by Pinocchio on 2024/9/26.
//

import UIKit
import Combine

class MainWeatherViewController: UIViewController {
    
    // MARK: - Variables
    private var viewModel = WeatherDataViewModels()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainWeatherTableViewCell.self , forCellReuseIdentifier: MainWeatherTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubview(tableView)
        
        //設定header畫面資訊
        let headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        tableView.tableHeaderView = headerView
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Functions
    // MARK: - Selectors
    // MARK: - UI Setup
}

// MARK: - Extension
extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "每小時天氣變化"
        case 1:
            return "這週天氣變化"
        default:
            return "----"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainWeatherTableViewCell.identifier, for: indexPath) as? MainWeatherTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .systemRed
        return cell
    }
    
    
}

