//
//  FourthViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/26.
//

import UIKit

class FourthViewController: UIViewController {
    let lable = {
        let label = OnboardingLabel()
        label.text = "영화 관련 영상(예고편) 확인 가능합니다.!"
        return label
    }()
    
    let imageView = {
        let view = OnboardingImageView(frame: .zero)
        view.image = UIImage(named: "FourImage")
        return view
    }()
    
    let button = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        return button
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
        view.addSubview(button)
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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view).inset(20)
            make.bottom.equalTo(view).offset(-20)
            make.height.equalTo(40)
        }
        
    }
    @objc func buttonTapped(){
        UserDefaultManager.standard.isSelect = true
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    

}
