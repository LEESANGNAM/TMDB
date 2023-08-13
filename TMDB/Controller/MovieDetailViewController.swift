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
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUpLabelUI()
        setUpMovieData()
        // Do any additional setup after loading the view.
    }
    
    func setUpLabelUI(){
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .boldSystemFont(ofSize: 24)
        
    }
    
    func setUpMovieData(){
        guard let movie = movie else { return }
        if let backURL = movie.backImageURL{ movieBackImageView.kf.setImage(with: backURL) }
        if let posterURL = movie.posterImageURL{ moviePosterImageView.kf.setImage(with: posterURL) }
        movieTitleLabel.text = movie.title
        overviewTitleLabel.text = "overview"
        overviewTextLabel.text = movie.overView
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = creditTableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        
        cell.backgroundColor = .blue
        return cell
        
        
    }
    
    
}


