//
//  NavigationPresenter.swift
//  OpenWeather
//
//  Created by Khateeb H. on 3/30/22.
//

import UIKit

protocol NavigationPresenter_Proto {
    func navigate(from: UIViewController, destination: UIViewController, title: String?, animated: Bool)
    func hideNavBar(from: UIViewController, isHidden: Bool)
    func pop(from: UIViewController, animted: Bool)
}

class NavigationPresenter: NavigationPresenter_Proto {
    
    func navigate(from: UIViewController, destination: UIViewController, title: String?, animated: Bool) {
        if let navController = from.navigationController {
            destination.title = title
            navController.pushViewController(destination, animated: animated)
        }
        else {
            destination.title = title
            from.present(UINavigationController(rootViewController: destination), animated: animated)
        }
    }
    
    func pop(from: UIViewController, animted: Bool) {
        if let navController = from.navigationController {
            navController.popViewController(animated: animted)
        }
    }
    
    func hideNavBar(from: UIViewController, isHidden: Bool) {
        if let navController = from.navigationController {
            navController.isNavigationBarHidden = isHidden
        }
    }
}

