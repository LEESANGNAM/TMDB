//
//  BaseViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setDelegate()
        // Do any additional setup after loading the view.
    }
    

    func setUpView(){
        view.backgroundColor = .white
        print("base ConfigureView")
    }
    func setConstraints(){
        print("base setConstraints")
    }
    
    func setDelegate(){
        
    }


}
