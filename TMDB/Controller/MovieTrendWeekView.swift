//
//  MovieTrendWeekView.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/28.
//

import UIKit

class MovieTrendWeekView: BaseView {
    
    let trendTitleLabel = {
        let label = UILabel()
        label.text = "금주의 트렌드!!!"
        label.titleLabelStyle()
        return label
    }()
    
    lazy var movieCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        view.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        view.collectionViewLayout = setCollectionViewLayout()
        return view
    }()
    func setCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 30
        // 전체 너비 가져와서 빼기
        let width = UIScreen.main.bounds.width - (spacing * 2)
        let itemSize = width
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        //컬렉션뷰 inset
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        // 최소 간격
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }
    
    override func setUpView() {
        addSubview(trendTitleLabel)
        addSubview(movieCollectionView)
    }
    
    override func setConstraints() {
        trendTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(trendTitleLabel.snp.bottom)
        }
        
    }
    
    
    
}
