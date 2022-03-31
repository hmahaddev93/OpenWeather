//
//  WeatherSearchView.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import UIKit

final class WeatherSearchView: UIView {

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search by city"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(WeatherHeaderCell.self, forCellReuseIdentifier: "WeatherHeaderCell")
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchBar, tableView])
        stackView.spacing = 8.0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .owLightGray
        addSubview(stackView)
        addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor, constant: 0),
            activityIndicatorView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 0)
        ])
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
