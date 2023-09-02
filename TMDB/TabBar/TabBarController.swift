//
//  TabbarController.swift
//  TMDB
//
//  Created by 이상남 on 2023/09/02.
//

import UIKit

class TabBarController: UITabBarController {
    let movieTrendWeekViewController = UINavigationController(rootViewController: MovieTrendWeekViewController())
    let multipleViewcontroller = UINavigationController(rootViewController: MultipleViewcontroller())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [movieTrendWeekViewController,multipleViewcontroller]
        setUpTabbar()
    }
    func setUpTabbar(){
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.backgroundColor = .white
        
        movieTrendWeekViewController.tabBarItem.title = "인기 영화"
        movieTrendWeekViewController.tabBarItem.image = UIImage(systemName: "popcorn.fill")
        multipleViewcontroller.tabBarItem.title = "모든 영상"
        multipleViewcontroller.tabBarItem.image = UIImage(systemName: "play.tv.fill")
    }
    
}
