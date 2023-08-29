//
//  NameSettingViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/30.
//

import UIKit


class NameSettingViewController: BaseViewController {
    
    let textField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요~~~"
        return textField
    }()
    
    var delegate: DelegatePatternTestProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let text = textField.text{
            delegate?.passNameData(name: text)
        }
    }
    
    override func setUpView() {
        super.setUpView()
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
}
