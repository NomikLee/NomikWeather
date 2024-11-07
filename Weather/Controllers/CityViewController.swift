//
//  CityViewController.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/19.
//

import UIKit

class CityViewController: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let cityTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地方天氣"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        view.addSubview(cityTableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)) //加入點擊空白處關鍵盤手勢
        view.addGestureRecognizer(tapGesture)
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cityTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    
    // MARK: - Selectors
    @objc func dismissKeyboard(){
        view.endEditing(true) //開啟點擊空白處關鍵盤
    }
    
    // MARK: - UI Setup
    
}
// MARK: - Extension
extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 60
        default:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar: UISearchBar = {
            let search = UISearchBar()
            search.translatesAutoresizingMaskIntoConstraints = false
            search.placeholder = "請輸入地方"
            search.keyboardType = .default
            return search
        }()
        
        let view: UIView = {
            let view = UIView()
            return view
        }()
        
        switch section {
        case 0:
            view.addSubview(searchBar)
            
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: view.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            return view
        default:
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        return cell
    }
}
