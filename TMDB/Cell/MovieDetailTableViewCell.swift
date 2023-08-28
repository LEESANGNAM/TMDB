//
//  MovieDetailTableViewCell.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit
import Kingfisher
class MovieDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileIamgeView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var characterJobLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }
    
    func setUpUI(){
        profileIamgeView.layer.cornerRadius = 20
        characterJobLabel.textColor = .systemGray3
    }
    
    
    func setUpCellCreditData(credit: Cast,type: CreditType){
        nameLabel.text = credit.name
        if let urlPath = credit.profilePath{
            let url = MovieAPIManager.getImageURL(path: urlPath)
            profileIamgeView.kf.setImage(with: url)
        } else{
            profileIamgeView.image = UIImage(systemName: "person.fill")
            profileIamgeView.backgroundColor = .systemIndigo
            profileIamgeView.tintColor = .white
        }
        characterJobLabel.text = credit.characterJobString
    }
    func setUpCellSimilarData(movie: SimilerResult){
        nameLabel.text = movie.title
        characterJobLabel.text = movie.releaseDate
        
        if let urlPath = movie.posterPath{
            let url = MovieAPIManager.getImageURL(path: urlPath)
            profileIamgeView.kf.setImage(with: url)
        }else{
            profileIamgeView.image = UIImage(systemName: "popcorn.fill")
            profileIamgeView.backgroundColor = .systemIndigo
            profileIamgeView.tintColor = .white
        }
    }
    func setUpCellVideoData(video: VideosResult){
        nameLabel.text = video.name
        characterJobLabel.text = video.changeFormatDateString()
        
        if let url = MovieAPIManager.getYoutubeImageURL(path: video.key){
            profileIamgeView.kf.setImage(with: url)
        }else{
            profileIamgeView.image = UIImage(systemName: "popcorn.fill")
            profileIamgeView.backgroundColor = .systemIndigo
            profileIamgeView.tintColor = .white
        }
    }
    
}
