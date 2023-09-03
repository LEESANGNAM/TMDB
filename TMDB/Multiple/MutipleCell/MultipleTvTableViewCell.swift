//
//  MultipleTvTableViewCell.swift
//  TMDB
//
//  Created by 이상남 on 2023/09/03.
//

import UIKit

class MultipleTvTableViewCell: BaseTableViewCell {
    let multiImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemBlue
        return view
    }()
    let stackView = {
        let view = UIStackView()
        view.spacing = 10
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    let titleLabel = {
        let label = UILabel()
        label.text = "일단 티비제목"
        return label
    }()
    let aveLabel = {
        let label = UILabel()
        label.text = "여긴 평점, 일단나와"
        return label
    }()
    let releseLabel = {
        let label = UILabel()
        label.text = "여긴 개봉일?"
        return label
    }()
    override func setUpUI() {
        self.backgroundColor = .systemYellow
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(aveLabel)
        stackView.addArrangedSubview(releseLabel)
        self.contentView.addSubview(multiImageView)
        self.contentView.addSubview(stackView)
    }
    override func setConstraints() {
        multiImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(10)
            make.width.equalTo(multiImageView.snp.height).multipliedBy(3.0/4.0)
        }
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(multiImageView.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide)
        }
    }
    
    func setCellData(movie: MultipleResult) {
        if let url = MovieAPIManager.getImageURL(path: movie.posterPath){
            multiImageView.kf.setImage(with: url)
        }
        titleLabel.text = movie.name
        aveLabel.text = "평점: \(movie.voteAverage ?? 0)  "
        releseLabel.text = "개봉일 : " + (movie.firstAirDate ?? "")
    }
}
