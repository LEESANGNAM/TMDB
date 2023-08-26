//
//  ThirdViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/26.
//

import UIKit

class ThirdViewController: UIViewController {
    let lable = {
        let label = OnboardingLabel()
        label.text = "비슷한 영화 확인가능 합니다."
        return label
    }()
    
    let imageView = {
        let view = OnboardingImageView(frame: .zero)
        view.image = UIImage(named: "ThreeImage")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
 
    func setUpUI(){
        addViewElements()
        addConstraints()
    }
    
    func addViewElements(){
        view.addSubview(lable)
        view.addSubview(imageView)
    }
    
    func addConstraints(){
        lable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(imageView.snp.top).offset(-20)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(20)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo( imageView.snp.width).multipliedBy(2)
            make.bottom.equalTo(view)
        }
        
    }
}
