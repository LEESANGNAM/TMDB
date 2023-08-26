//
//  IntroViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/26.
//

import UIKit

enum OnboardingViewType: CaseIterable{
    case first
    case second
    case third
    case fourth
    
    var viewController: UIViewController{
        switch self {
        case .first:
            return FirstViewController()
        case .second:
            return SecondViewController()
        case .third:
            return ThirdViewController()
        case .fourth:
            return FourthViewController()
        }
    }
    
}


class IntroViewController: UIPageViewController{
    var list = OnboardingViewType.allCases.map { type in
        type.viewController
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else {return}
        setViewControllers([first], direction: .forward, animated: true)
        
    }
    

}

extension IntroViewController: UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        if nextIndex >= list.count{
            UserDefaultManager.standard.isSelect = true
            return nil
        }else{
            return  list[nextIndex]
        }

    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
    
}
