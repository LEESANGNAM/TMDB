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
    @IBOutlet weak var creditTableView: UITableView!
    
    var movie: MovieResult?
    
    var castList: [Cast] = []
    var crewList: [Cast] = []
    var sections = CreditType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUpLabelUI()
        setUpMovieData()
        callRequest()
        // Do any additional setup after loading the view.
    }
    
    func setUpLabelUI(){
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .boldSystemFont(ofSize: 24)
        
    }
    
    func setUpMovieData(){
        guard let movie = movie else { return }
        if let backURL = MovieAPIManager.getImageURL(path: movie.backdropPath) { movieBackImageView.kf.setImage(with: backURL) }
        if let posterURL = MovieAPIManager.getImageURL(path: movie.posterPath) { moviePosterImageView.kf.setImage(with: posterURL) }
        movieTitleLabel.text = movie.title
        overviewTitleLabel.text = "overview"
        overviewTextLabel.text = movie.overview
        
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
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? castList.count : crewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = creditTableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        let person = indexPath.section == 0 ? castList[indexPath.row] : crewList[indexPath.row]
        cell.setUpCellData(credit: person, type: sections[indexPath.section])
        return cell
        
    }
}

extension MovieDetailViewController{
    func callRequest(){
        guard let movie = movie else { return }
        MovieAPIManager.shared.callRequest(type: .credits(movie.id)) { data in
            self.castList = Array(data.cast.prefix(10)) //데이터 10개씩 보여주기
            self.crewList = Array(data.crew.prefix(10))
            self.creditTableView.reloadData()
        }
    }
}

