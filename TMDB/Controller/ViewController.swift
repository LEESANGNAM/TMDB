//
//  ViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    @IBOutlet weak var weekTitleLabel: UILabel!
    var page = 1
    var movieList:[MovieResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieCollectionView.prefetchDataSource = self
        weekTitleLabel.text = "금주의 트렌드!!!!"
        weekTitleLabel.titleLabelStyle()
        setUpCollectionView()
        callRequest()
    }
    
//   func navie
    
}

// MARK: - API
extension ViewController {
    func callRequest(){
        MovieAPIManager.shared.callRequestTrending(type: .trending(page)){ responseMovieList in
            self.movieList += responseMovieList
            self.movieCollectionView.reloadData()
        }
    }
}


// MARK: - collectionView
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        cell.moviePosterIamgeView.backgroundColor = .blue
        cell.setUpCellData(movie: movieList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as! MovieDetailViewController
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setUpCollectionView(){
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        setCollectionViewCell()
        setCollectionViewLayout()
    }
    
    func setCollectionViewCell(){
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    func setCollectionViewLayout(){
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
        
        movieCollectionView.collectionViewLayout = layout
        
    }
    
}

extension ViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(indexPaths)
        for indexPath in indexPaths{
            print("page:",page)
            if movieList.count - 1 == indexPath.row && page < 100{ // 계속 데이터가 쌓여서 메모리가 너무많이 차지하게된다. 주말에 알아보자
                print("page:",page)
                page += 1
                callRequest()
            }
        }
    }
}
