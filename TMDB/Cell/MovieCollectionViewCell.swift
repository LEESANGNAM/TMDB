//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ratingTitleLabel: UILabel!
    
    @IBOutlet weak var ratingValueLabel: UILabel!
    
    @IBOutlet weak var moviePosterIamgeView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var moviewDateLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        setUpLabelDesign()
    }
    func setUpCellData(movie: Movie){
        ratingTitleLabel.text = "평점"
        ratingValueLabel.text = "\(movie.rating)"
        if let url = movie.imageURL{
            moviePosterIamgeView.kf.setImage(with: url)
        }
        movieTitleLabel.text = movie.title
        moviewDateLabel.text = movie.date
        detailLabel.text = "자세히보기!!!!!!!"
        
    }

    func setUpLabelDesign(){
        ratingTitleLabel.whiteTextWithBlueBackground()
        ratingTitleLabel.textAlignment = .center
        ratingValueLabel.blackTextWithWhiteBackground()
        ratingValueLabel.textAlignment = .center
        movieTitleLabel.titleLabelStyle()
    }
    
    
}
