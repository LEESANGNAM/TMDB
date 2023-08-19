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
    
    var castList: [Cast] = []
    var crewList: [Cast] = []
    var similerList: [SimilerResult] = []
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
        
        if movieSegumentContol.selectedSegmentIndex == 0 {
            let person = indexPath.section == 0 ? castList[indexPath.row] : crewList[indexPath.row]
                cell.setUpCellCreditData(credit: person, type: sections[indexPath.section])
        } else if movieSegumentContol.selectedSegmentIndex == 1 {
            let similerMovie = similerList[indexPath.row]
            cell.setUpCellsimilarData(movie: similerMovie)
        }
        return cell
        
    }
}

extension MovieDetailViewController{
    func callRequestCredit(){
        guard let movie = movie else { return }
        MovieAPIManager.shared.callRequestCredit(type: .credits(movie.id)) { data in
            self.castList = Array(data.cast.prefix(10)) //데이터 10개씩 보여주기
            self.crewList = Array(data.crew.prefix(10))
            self.creditTableView.reloadData()
        }
    }
    func callRequestSimiler(){
        guard let movie = movie else { return }
        MovieAPIManager.shared.callRequestSimiler(type: .similar(movie.id)) { data in
            self.similerList = data.results
            print(self.similerList)
            self.creditTableView.reloadData()
        }
    }
}

