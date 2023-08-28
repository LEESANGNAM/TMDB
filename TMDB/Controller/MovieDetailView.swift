//
//  MovieDetailView.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/28.
//

import UIKit


class MovieDetailView: BaseView {
    lazy var movieBackImageView = {
        let image =  UIImageView()
        image.backgroundColor = .blue
        return image
    }()
    lazy var moviePosterImageView = {
        let image =  UIImageView()
        image.backgroundColor = .gray
        return image
    }()
    lazy var movieTitleLabel = {
        let label =  UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    lazy var overviewStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    lazy var overviewTitleLabel = {
        let label =  UILabel()
        label.text = "overview"
        return label
    }()
    lazy var overviewlineView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var overviewTextLabel = {
        let label =  UILabel()
        label.numberOfLines = 2
        return label
    }()
    lazy var moreButton = {
        let button =  UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    lazy var movieSegumentContol = {
        let segment =  UISegmentedControl(items: ["등장인물", "함께 시청된 콘텐츠", "예고편 및 다른 영상"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    lazy var creditTableView = {
        let view =  UITableView()
        return view
    }()
    lazy var viewList = [movieBackImageView,moviePosterImageView,movieTitleLabel,overviewStackView,moreButton,movieSegumentContol,creditTableView]
    lazy var stackViewList = [overviewTitleLabel,overviewlineView,overviewTextLabel]
    override func setUpView() {
        stackViewList.map {
            overviewStackView.addArrangedSubview($0)
        }
        viewList.map {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        movieBackImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.4)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(20)
            make.top.equalTo(movieBackImageView.snp.top).offset(10)
            make.height.equalTo(20)
        }
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(movieBackImageView.snp.bottom).offset(-10)
            make.width.equalTo(movieBackImageView).multipliedBy(0.2)
            make.leading.equalTo(movieTitleLabel.snp.leading)
            make.width.equalTo(moviePosterImageView.snp.height).multipliedBy(3.0/5.0)
        }
        overviewStackView.snp.makeConstraints { make in
            make.top.equalTo(movieBackImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.lessThanOrEqualTo(130)
        }
        overviewTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        overviewlineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        overviewTextLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
        }
        moreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(overviewStackView.snp.bottom).offset(10)
            make.height.equalTo(34)
        }
        movieSegumentContol.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        creditTableView.snp.makeConstraints { make in
            make.top.equalTo(movieSegumentContol.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        
        
    }
    
    
}

