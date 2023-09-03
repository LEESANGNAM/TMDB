//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit
import Kingfisher

class MovieDetailViewController: BaseViewController {

    var mainView = MovieDetailView()
    
    var isMoreSelect = false
    
    var movie: Any?
    
    var creditList: [[Cast]] = []
    var similerVideosList: [Any] = []
    var sections = CreditType.allCases
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUpLabelUI()
        setUpMovieData()
        callRequestCredit()
        // Do any additional setup after loading the view.
    }
    
    func setUpLabelUI(){
        mainView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        mainView.movieSegumentContol.addTarget(self, action: #selector(segmentTapped(_:)), for: .valueChanged)

    }
    
    func setUpMovieData(){
        guard let movie = movie else { return }
        if let movie = movie as? MovieResult {
            if let backURL = MovieAPIManager.getImageURL(path: movie.backdropPath) {
                mainView.movieBackImageView.kf.setImage(with: backURL) }
            if let posterURL = MovieAPIManager.getImageURL(path: movie.posterPath) {
                mainView.moviePosterImageView.kf.setImage(with: posterURL) }
            mainView.movieTitleLabel.text = movie.title
            mainView.overviewTextLabel.text = movie.overview == "" ? "영화설명 없음" : movie.overview
        }
        if let movie = movie as? SimilerResult {
            if let backURL = MovieAPIManager.getImageURL(path: movie.backdropPath) { mainView.movieBackImageView.kf.setImage(with: backURL) }
            if let posterURL = MovieAPIManager.getImageURL(path: movie.posterPath) { mainView.moviePosterImageView.kf.setImage(with: posterURL) }
            mainView.movieTitleLabel.text = movie.title
            mainView.overviewTextLabel.text = movie.overview == "" ? "영화설명 없음" : movie.overview
        }
        
    }
    @objc func moreButtonTapped(_ sender: UIButton) {
        if isMoreSelect {
            mainView.overviewTextLabel.numberOfLines = 2
            isMoreSelect.toggle()
            mainView.moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }else{
            mainView.overviewTextLabel.numberOfLines = 0
            isMoreSelect.toggle()
            mainView.moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        mainView.overviewStackView.layoutIfNeeded()
    }
    
    
    @objc func segmentTapped(_ sender: UISegmentedControl) {
        print(mainView.movieSegumentContol.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0{
            callRequestCredit()
        }else if sender.selectedSegmentIndex == 1 {
            callRequestSimiler()
        }else{
            callRequestVideos()
        }
    }
    
    
}

// MARK: - tableview
extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func setTableView(){
        mainView.creditTableView.dataSource = self
        mainView.creditTableView.delegate = self
        mainView.creditTableView.rowHeight = 100
        setTableViewCell()
    }
    
    func setTableViewCell(){
        let nib = UINib(nibName: MovieDetailTableViewCell.identifier, bundle: nil)
        mainView.creditTableView.register(nib, forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getSegumentContolSelectedIndex() == 0 ? creditList.count : 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return getSegumentContolSelectedIndex() == 0 ? sections[section].rawValue : ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return getSegumentContolSelectedIndex() == 0 ? creditList[section].count : similerVideosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.creditTableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        
        setUpTableViewCellData(cell: cell, indexPath: indexPath)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if getSegumentContolSelectedIndex() == 1 {
            let similerMovie = similerVideosList[indexPath.row] as? SimilerResult
            movie = similerMovie
            print(movie)
            setUpMovieData()
            callRequestSimiler()
        }else if getSegumentContolSelectedIndex() == 2,
                 let videosMovie = similerVideosList[indexPath.row] as? VideosResult,
                 let url = MovieAPIManager.getYoutubeVideosBaseURL(path: videosMovie.key){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func getSegumentContolSelectedIndex() -> Int{
        return mainView.movieSegumentContol.selectedSegmentIndex
    }
    
    
    func setUpTableViewCellData(cell: MovieDetailTableViewCell, indexPath: IndexPath){
        if getSegumentContolSelectedIndex() == 0 {
            let person = creditList[indexPath.section][indexPath.row]
            let type = sections[indexPath.section]
                cell.setUpCellCreditData(credit: person, type: type)
        }else{
            if let similerMovie = similerVideosList[indexPath.row] as? SimilerResult{
                cell.setUpCellSimilarData(movie: similerMovie)
            }
            if let movieVideos = similerVideosList[indexPath.row] as? VideosResult{
                cell.setUpCellVideoData(video: movieVideos)
            }
        }
    }
    
}

extension MovieDetailViewController{
    func callRequestCredit(){
        if let movie = movie as? MovieResult { callRequestCreditData(id: movie.id) }
        if let similerMovie = movie as? SimilerResult {callRequestCreditData(id: similerMovie.id)}
    }
    
    func callRequestSimiler(){
        if let movie = movie as? MovieResult {callRequestSimilerData(id: movie.id)}
        if let similerMovie = movie as? SimilerResult {callRequestSimilerData(id: similerMovie.id)}
    }
    func callRequestVideos(){
        if let movie = movie as? MovieResult { callRequestVideosData(id: movie.id)}
        if let similerMovie = movie as? SimilerResult {callRequestVideosData(id: similerMovie.id)}
    }
    
    func callRequestSimilerData(id: Int){
        MovieAPIManager.shared.callRequest(type: .similar(id)) { (data: Similer) in
            self.similerVideosList = []
            self.similerVideosList = data.results
            self.mainView.creditTableView.reloadData()
        }
    }
    func callRequestCreditData(id: Int){
        MovieAPIManager.shared.callRequest(type: .credits(id)) { (data :MoviePersons) in
            let castList = Array(data.cast.prefix(10)) //데이터 10개씩 보여주기
            let crewList = Array(data.crew.prefix(10))
            self.creditList = []
            self.creditList = [castList,crewList]
            self.mainView.creditTableView.reloadData()
        }
    }
    func callRequestVideosData(id: Int){
        MovieAPIManager.shared.callRequest(type: .videos(id)) { (data: Videos) in
            self.similerVideosList = []
            self.similerVideosList = data.results
            self.mainView.creditTableView.reloadData()
        }
    }
}

