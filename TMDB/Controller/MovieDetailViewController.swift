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
        MovieAPIManager.shared.callRequest(type: .credits(movie.id)) { data in    // 여기 로직 뭔가 바꿀수 있을거같다. 일단체크
            self.castList = data.cast
            self.crewList = data.crew
//            let castList = json["cast"].arrayValue
//            print(castList)
//            var castArray:[Cast] = []
//            for item in castList{
//                let name = item["name"].stringValue
//                let profileString = item["profile_path"].stringValue
//                let department = item["known_for_department"].stringValue
//                let character = item["character"].stringValue
//                let cast = Cast(group: .cast, name: name, profileString: profileString, department: department, character: character)
//                castArray.append(cast)
//                if castArray.count == 10{
//                    self.personList.append(castArray)
//                    break
//                }
//            }
//            let crewList = json["crew"].arrayValue
//            print(crewList)
//            var crewArray:[Crew] = []
//            for item in crewList{
//                if item["known_for_department"].stringValue == "Acting"{
//                    continue
//                }else{
//                    let name = item["name"].stringValue
//                    let profileString = item["profile_path"].stringValue
//                    let department = item["known_for_department"].stringValue
//                    let job = item["job"].stringValue
//                    let crew = Crew(group: .crew, name: name, profileString: profileString, department: department, job: job)
//                    crewArray.append(crew)
//                    if crewArray.count == 10{
//                        self.personList.append(crewArray)
//                        break
//                    }
//                }
//            }
            self.creditTableView.reloadData()
        }
    }
}

