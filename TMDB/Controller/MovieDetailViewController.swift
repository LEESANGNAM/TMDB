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
    var similerList: [SimilerResult] = []
    var videosList: [VideosResult] = []
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
        if movieSegumentContol.selectedSegmentIndex == 0 {
            return creditList.count
        } else if movieSegumentContol.selectedSegmentIndex == 1 {
           return 1
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if movieSegumentContol.selectedSegmentIndex == 0 {
            return sections[section].rawValue
        } else if movieSegumentContol.selectedSegmentIndex == 1 {
           return ""
        } else{
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieSegumentContol.selectedSegmentIndex == 0 {
            return creditList[section].count
        } else if movieSegumentContol.selectedSegmentIndex == 1 {
           return similerList.count
        } else {
            return videosList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = creditTableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        
        if movieSegumentContol.selectedSegmentIndex == 0 {
            let person = creditList[indexPath.section][indexPath.row]
                cell.setUpCellCreditData(credit: person, type: sections[indexPath.section])
        } else if movieSegumentContol.selectedSegmentIndex == 1 {
            let similerMovie = similerList[indexPath.row]
            cell.setUpCellSimilarData(movie: similerMovie)
        }
        else {
            let movieVideos = videosList[indexPath.row]
            cell.setUpCellVideoData(video: movieVideos)
        }
        return cell
        
    }
}

extension MovieDetailViewController{
    func callRequestCredit(){
        guard let movie = movie else { return }
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
            self.similerList = data
//            print(self.similerList)
            self.creditTableView.reloadData()
        }
    }
    func callRequestVideos(){
        guard let movie = movie else { return }
        MovieAPIManager.shared.callRequestVideos(type: .videos(movie.id)) { data in
            self.videosList = data
            print(self.videosList)
            self.creditTableView.reloadData()
        }
    }
}

