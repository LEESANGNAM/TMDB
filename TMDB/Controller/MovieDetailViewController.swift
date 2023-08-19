//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieBackImageView: UIImageView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewTextLabel: UILabel!
    
    @IBOutlet weak var overviewStackView: UIStackView!
    @IBOutlet weak var moreButton: UIButton!
    
    
    @IBOutlet weak var creditTableView: UITableView!
    @IBOutlet weak var movieSegumentContol: UISegmentedControl!
    
    var isMoreSelect = false
    
    var movie: MovieResult?
    
    var creditList: [[Cast]] = []
    var similerVideosList: [Any] = []
    var sections = CreditType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUpLabelUI()
        setUpMovieData()
        callRequestCredit()
        // Do any additional setup after loading the view.
    }
    
    func setUpLabelUI(){
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .boldSystemFont(ofSize: 24)
        overviewTextLabel.numberOfLines = 2
        moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        moreButton.tintColor = .darkGray
    }
    
    func setUpMovieData(){
        guard let movie = movie else { return }
        if let backURL = MovieAPIManager.getImageURL(path: movie.backdropPath) { movieBackImageView.kf.setImage(with: backURL) }
        if let posterURL = MovieAPIManager.getImageURL(path: movie.posterPath) { moviePosterImageView.kf.setImage(with: posterURL) }
        movieTitleLabel.text = movie.title
        overviewTitleLabel.text = "overview"
        overviewTextLabel.text = movie.overview
        
    }
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        if isMoreSelect {
            overviewTextLabel.numberOfLines = 2
            isMoreSelect.toggle()
            moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }else{
            overviewTextLabel.numberOfLines = 0
            isMoreSelect.toggle()
            moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        overviewStackView.layoutIfNeeded()
    }
    
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
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
        creditTableView.dataSource = self
        creditTableView.delegate = self
        creditTableView.rowHeight = 100
        setTableViewCell()
    }
    
    func setTableViewCell(){
        let nib = UINib(nibName: MovieDetailTableViewCell.identifier, bundle: nil)
        creditTableView.register(nib, forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieSegumentContol.selectedSegmentIndex == 0 ? creditList.count : 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return movieSegumentContol.selectedSegmentIndex == 0 ? sections[section].rawValue : ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movieSegumentContol.selectedSegmentIndex == 0 ? creditList[section].count : similerVideosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = creditTableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        
        setUpTableViewCellData(cell: cell, indexPath: indexPath)
       
        return cell
    }
    
    func setUpTableViewCellData(cell: MovieDetailTableViewCell, indexPath: IndexPath){
        if movieSegumentContol.selectedSegmentIndex == 0 {
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
        guard let movie = movie else { return }
//        let group = DispatchGroup()
//        group.enter()
        MovieAPIManager.shared.callRequestCredit(type: .credits(movie.id)) { data in
            let castList = Array(data.cast.prefix(10)) //데이터 10개씩 보여주기
            let crewList = Array(data.crew.prefix(10))
            self.creditList = [castList,crewList]
            self.creditTableView.reloadData()
        }
    }
    func callRequestSimiler(){
        guard let movie = movie else { return }
        MovieAPIManager.shared.callRequestSimiler(type: .similar(movie.id)) { data in
            print("------------------------------similer",data)
            self.similerVideosList = []
            self.similerVideosList = data
            self.creditTableView.reloadData()
        }
    }
    func callRequestVideos(){
        guard let movie = movie else { return }
        MovieAPIManager.shared.callRequestVideos(type: .videos(movie.id)) { data in
            print("------------------------------videos",data)
            self.similerVideosList = []
            self.similerVideosList = data
            self.creditTableView.reloadData()
        }
    }
}

