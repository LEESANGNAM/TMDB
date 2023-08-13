//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit

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
        // Do any additional setup after loading the view.
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
