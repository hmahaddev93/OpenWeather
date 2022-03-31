//
//  WeatherHeaderCell.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import UIKit

class WeatherHeaderCell: UITableViewCell {

    var model: CityWeatherResponse? {
        didSet {
            self.cityLabel.text = model?.name?.uppercased()
            if let iconId = model?.weather?.first?.icon {
                self.iconImageView.loadWeatherIcon(iconId: iconId)
            }
            self.weatherLabel.text = model?.weather?.first?.main
            if let temp = model?.temperature?.temp {
                self.tempLabel.text = "\(temp)℉"
            } else {
                self.tempLabel.text = "N/A"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cityLabel = MyLabel(size: 24, isBold: true, color: .darkGray)
    private let weatherLabel = MyLabel(size: 16, isBold: true, color: .gray)
    private let tempTitleLabel: MyLabel = {
        let label = MyLabel(size: 14, color: .gray)
        label.text = "Temperature:"
        return label
    }()
    private let tempLabel = MyLabel(size: 32, isBold: true, color: .black)
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(), tempTitleLabel, tempLabel, UIView()])
        stackView.spacing = 8.0
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityLabel, iconImageView, weatherLabel, tempStackView])
        stackView.spacing = 1.0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 10.0
        return stackView
    }()
    
    private func commonInit() {
        backgroundColor = .clear
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            cityLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

