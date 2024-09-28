//
//  MainWeatherTableViewCell.swift
//  Weather
//
//  Created by Pinocchio on 2024/9/28.
//

import UIKit

class MainWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "MainWeatherTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
