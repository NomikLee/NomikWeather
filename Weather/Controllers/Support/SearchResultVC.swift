//
//  SearchResultVC.swift
//  Weather
//
//  Created by Pinocchio on 2024/11/8.
//

import UIKit
import MapKit
import Combine

class SearchResultVC: UIViewController {
    
    // MARK: - Variables
    private var searchResultsList: [MKMapItem] = []
    var updateSearchSubject = PassthroughSubject<String, Never>()
    private var cancellables: Set<AnyCancellable> = [] //AnyCancellable 使用
    
    // MARK: - UI Components
    private let searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(searchResultTableView)
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        updateSearchSubject.sink { [weak self] result in
            self?.searchLocation(result)
        }
        .store(in: &cancellables)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    private func searchLocation(_ query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            
            guard let mapItems = response?.mapItems else { return }
            
            self.searchResultsList = mapItems
            self.searchResultTableView.reloadData()
        }
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    
}
// MARK: - Extension
extension SearchResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let searchResultsItem = searchResultsList[indexPath.row]
        cell.textLabel?.text = "\(searchResultsItem.name ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //讓點選時高亮取消
        let selectedItem = searchResultsList[indexPath.row]
        print("選擇地點：\(selectedItem.placemark.administrativeArea ?? "無名稱") \(selectedItem.placemark.locality ?? "無名稱" )")
    }
}
