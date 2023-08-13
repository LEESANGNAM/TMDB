//
//  ViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var movieList:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView()
        callRequest()
    }
    
    func callRequest(){
        MovieAPIManager.shared.callRequest(type: .trending) { json in
            let jsonMovieList = json["results"].arrayValue
            print(jsonMovieList)
            for item in jsonMovieList{
                let id = item["id"].intValue
                let title = item["title"].stringValue
                let overView = item["overView"].stringValue
                let date = item["release_date"].stringValue
                let posterURL = item["poster_path"].stringValue
                let rating = item["vote_average"].doubleValue
                let movie = Movie(id: id, title: title, overView: overView, date: date, posterURLString: posterURL, rating: rating)
                
                self.movieList.append(movie)
            }
            self.movieCollectionView.reloadData()
        }
    }
    
}


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

