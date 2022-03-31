//
//  ViewController.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WeatherService.shared.weather(by: "New york") { result in
            switch result {
                
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

