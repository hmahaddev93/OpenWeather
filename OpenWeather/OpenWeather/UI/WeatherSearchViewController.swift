//
//  WeatherSearchViewController.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import UIKit

final class WeatherSearchViewController: UIViewController {

    private let viewModel: WeatherSearchViewModel
    private let weatherSearchView = WeatherSearchView()
    
    private let alertPresenter: AlertPresenter_Proto = AlertPresenter()
    private let navPresenter: NavigationPresenter = NavigationPresenter()

    init(viewModel: WeatherSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = weatherSearchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        weatherSearchView.tableView.dataSource = self
        weatherSearchView.tableView.delegate = self
        weatherSearchView.searchBar.delegate = self
    }
    
    private func update() {
        weatherSearchView.tableView.reloadData()
    }
    
    private func display(error: Error) {
        alertPresenter.present(from: self,
                               title: "Unexpected Error",
                               message: "\(error.localizedDescription)",
                               dismissButtonTitle: "OK")
    }
    
    private func showSpinner() {
        weatherSearchView.activityIndicatorView.startAnimating()
    }
    
    private func hideSpinner() {
        self.weatherSearchView.activityIndicatorView.stopAnimating()
    }

}

extension WeatherSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let city = searchBar.text,
              city.replacingOccurrences(of: " ", with: "") != "" else {
            return
        }
        
        showSpinner()
        viewModel.searchWeather(by: city) { [unowned self]result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.hideSpinner()
                    self.update()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.hideSpinner()
                    self.display(error: error)
                }
            }
        }
    }
}

extension WeatherSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weathers = viewModel.cityWeather.weather {
            return weathers.count()
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath) as? SchoolCell {
//            let school = viewModel.schools[indexPath.row]
//            cell.model = school
//            return cell
//        }
        return UITableViewCell()
    }
}

extension WeatherSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
//        let school = viewModel.schools[indexPath.row]
//        self.navPresenter.navigateToSchoolDeail(school: school, from: self, animated: true)
    }
}


