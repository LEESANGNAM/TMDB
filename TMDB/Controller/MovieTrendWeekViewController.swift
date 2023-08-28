//
//  ViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit

class MovieTrendWeekViewController: BaseViewController {
    
    let mainView = MovieTrendWeekView()
    
    var page = 1
    var movieList:[MovieResult] = []
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "인기 영화 리스트"
        callRequest()
    }
    override func setDelegate() {
        mainView.movieCollectionView.dataSource = self
        mainView.movieCollectionView.delegate = self
        mainView.movieCollectionView.prefetchDataSource = self
    }
    
//   func navie
    
}

// MARK: - API
extension MovieTrendWeekViewController {
    func callRequest(){
        MovieAPIManager.shared.callRequestTrending(type: .trending(page)){ responseMovieList in
            self.movieList += responseMovieList
            self.mainView.movieCollectionView.reloadData()
        }
    }
}


// MARK: - collectionView
extension MovieTrendWeekViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        cell.setUpCellData(movie: movieList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        let vc = MovieDetailViewController()
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MovieTrendWeekViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(indexPaths)
        for indexPath in indexPaths{
            print("page:",page)
            if movieList.count - 5 == indexPath.row && page < 100{ // 계속 데이터가 쌓여서 메모리가 너무많이 차지하게된다. 주말에 알아보자
                print("page:",page)
                page += 1
                callRequest()
            }
        }
    }
}
