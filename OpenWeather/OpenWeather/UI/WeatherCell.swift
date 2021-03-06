//
//  WeatherCell.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import UIKit

class WeatherCell: UITableViewCell {

    var model: Weather? {
        didSet {
            if let iconId = model?.icon {
                self.iconImageView.loadWeatherIcon(iconId: iconId)
            }
            self.weatherLabel.text = model?.main
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let weatherLabel = MyLabel(size: 16, isBold: true, color: .gray)
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, weatherLabel])
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

