//
//  MainWeatherTableViewCell.swift
//  Weather
//
//  Created by Pinocchio on 2024/9/28.
//

import UIKit

class MainWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "MainWeatherTableViewCell"
    
    // MARK: - Variables
    // MARK: - UI Components
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // MARK: - Selectors
    // MARK: - UI Setup
    // MARK: - Extension
    
}
