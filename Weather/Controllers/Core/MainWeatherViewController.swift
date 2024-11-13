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
    private var cancellables: Set<AnyCancellable> = [] //AnyCancellable 使用
    
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false //關閉Scroll線
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(HourlyWeatherTableViewCell.self , forCellReuseIdentifier: HourlyWeatherTableViewCell.identifier)
        tableView.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: DailyWeatherTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true) //不使用NavigationBar
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)
        
        //初始設定header畫面並且放入tableHeaderView
        let headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        tableView.tableHeaderView = headerView
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
        changeDayEvening()
    }
    
    // MARK: - Functions
    private func changeDayEvening() {
        LocationManerger.shared.updateLocationSubject.sink { [weak self] location in
            self?.viewModel.fetchWeatherCurrentData(latitude: location.latitude.description, longitude: location.longitude.description)
            self?.viewModel.fetchWeatherDailyData(latitude: location.latitude.description, longitude: location.longitude.description)
        }
        .store(in: &cancellables)
        
        viewModel.$currentDatas.sink { [weak self] data in
            if data?.current.isDay == 1 {
                self?.backgroundImageView.image = UIImage(named: "sum")
            }else {
                self?.backgroundImageView.image = UIImage(named: "black")
            }
        }
        .store(in: &cancellables)
        
        viewModel.$dailyDatas.sink { [weak self] _ in
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: view.bounds.height),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extension
extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    //Sections數量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //修改Header的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 3
        default:
            return 35
        }
    }
    
    //Sections的row數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
    }
    
    //row的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        default:
            return 60
        }
    }
    
    //自己定義section的ui介面
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 30, weight: .semibold)
            label.textAlignment = .right
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let headerView: UIView = {
            let view = UIView()
            return view
        }()
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        switch section {
        case 0:
            return headerView
        default:
            label.text = "未來十日天氣"
            return headerView
        }
    }
    
    //UITableView 準備顯示某一行時呼叫
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableView 的 dequeueReusableCell 來取得可重複使用的 cell
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.identifier, for: indexPath) as? HourlyWeatherTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.identifier, for: indexPath) as? DailyWeatherTableViewCell else { return UITableViewCell() }
            
            cell.configureDailyData(to: viewModel.dailyDatas?.daily.time[indexPath.row] ?? "",
                                    dailyCode: viewModel.dailyDatas?.daily.weatherCode[indexPath.row] ?? 0,
                                    dailyProbability: viewModel.dailyDatas?.daily.precipitationProbabilityMax[indexPath.row] ?? 0,
                                    dailyPrecipitationSum: viewModel.dailyDatas?.daily.precipitationSum[indexPath.row] ?? 0.0,
                                    dailyMaxTemp: viewModel.dailyDatas?.daily.temperature2mMax[indexPath.row] ?? 0.0, dailyMinTemp: viewModel.dailyDatas?.daily.temperature2mMin[indexPath.row] ?? 0.0)
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //讓點選時高亮取消
    }
}

