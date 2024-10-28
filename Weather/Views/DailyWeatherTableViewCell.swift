//
//  DailyWeatherTableViewCell.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/26.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    static let identifier = "DailyWeatherTableViewCell"
    
    // MARK: - Variables
    // MARK: - UI Components
    private let dateDailyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "週一"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(dateDailyLabel)
        
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func configureDailyData(to dateDaily: String) {
        guard let formatterWeekDate = formatterWeek(from: dateDaily) else { return }
        dateDailyLabel.text = "週\(formatterWeekDate)"
    }
    
    //把日期轉成星期
    private func formatterWeek(from dateString: String) -> String.SubSequence? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 日期格式進行解析
        dateFormatter.locale = Locale(identifier: "zh_Hant") // 設定繁體中文

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "EEEE" // "EEEE" 顯示完整的星期名稱
            let dataSplit = dateFormatter.string(from: date)
            return dataSplit.split(separator: "星期").last //切割星期部分只能數字字串
        }
        return nil
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            dateDailyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateDailyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateDailyLabel.widthAnchor.constraint(equalToConstant: 50),
            dateDailyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
// MARK: - Extension

