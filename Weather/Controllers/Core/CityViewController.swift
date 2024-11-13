//
//  CityViewController.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import UIKit
import Combine

class CityViewController: UIViewController {
    
    // MARK: - Variables
    private let viewModel = WeatherDataViewModels()
    
    // MARK: - UI Components
    private let cityTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        return tableView
    }()
    
    private let citySearch: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultVC())
        search.searchBar.placeholder = "搜尋城市或地區"
        return search
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地方天氣"
        navigationController?.navigationBar.prefersLargeTitles = true //顯示大標題
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = citySearch
        navigationItem.hidesSearchBarWhenScrolling = false //把捲動時才出現搜尋欄的功能關掉
        
        view.addSubview(cityTableView)
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        citySearch.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cityTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    
    // MARK: - Selectors
    
    // MARK: - UI Setup
    
}

// MARK: - Extension
extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    //調整Section數量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //調整Row數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //調整section的footer高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    //section的footer加入UIView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //調整Row高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        
        cell.configureCityData(code: 0,
                               name: "新莊區",
                               Temp: 43,
                               highTemp: viewModel.dailyCityDatas?.daily.temperature2mMax[indexPath.row] ?? 0.0,
                               lowTemp: viewModel.dailyCityDatas?.daily.temperature2mMin[indexPath.row] ?? 0.0
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //讓點選時高亮取消
        let vc = CityWeatherVC()
        present(vc, animated: true)
    }
}


extension CityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard let resultsController = searchController.searchResultsController as? SearchResultVC else { return }
        
        resultsController.updateSearchSubject.send(text)
    }
    
    
}
