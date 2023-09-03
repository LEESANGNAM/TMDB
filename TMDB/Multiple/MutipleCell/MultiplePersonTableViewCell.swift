//
//  MultiplePersonTableViewCell.swift
//  TMDB
//
//  Created by 이상남 on 2023/09/03.
//

import UIKit

class MultiplePersonTableViewCell: BaseTableViewCell {
    let multiImageView1 = {
        let view = UIImageView()
        view.backgroundColor = .systemBlue
        return view
    }()
    let multiImageView2 = {
        let view = UIImageView()
        view.backgroundColor = .systemBlue
        return view
    }()
    let multiImageView3 = {
        let view = UIImageView()
        view.backgroundColor = .systemBlue
        return view
    }()
    let posterStackView = {
        let view = UIStackView()
        view.spacing = 10
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    let nameLabel = {
        let label = UILabel()
        label.text = "여긴 사람 이름"
        return label
    }()
    let contentLabel = {
        let label = UILabel()
        label.text = "출연작"
        return label
    }()
    
    override func setUpUI() {
        self.backgroundColor = .systemBlue
        posterStackView.addArrangedSubview(multiImageView1)
        posterStackView.addArrangedSubview(multiImageView2)
        posterStackView.addArrangedSubview(multiImageView3)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(posterStackView)
    }
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        posterStackView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
    func setCellData(person: MultipleResult) {
        if let name = person.name {  nameLabel.text = name }
        if let department = person.knownForDepartment { contentLabel.text = department }
        let movieList = person.knownFor
        for (index,subview) in posterStackView.subviews.enumerated(){
            if let imageView = subview as? UIImageView,
               let movieList {
                if index < movieList.count{
                    if let url = MovieAPIManager.getImageURL(path:movieList[index].posterPath){
                        imageView.kf.setImage(with: url)
                    }
                }
            }
        }
    }
}
