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
        // Initialization code
    }
    
    
    func setUpCellData(credit: MoviePeople){
        switch credit.group{
        case .cast:
            if let castPerson = credit as? Cast{
                nameLabel.text = castPerson.name
                characterJobLabel.text = "\(castPerson.character) / \(castPerson.department)"
                profileIamgeView.kf.setImage(with: castPerson.profileURL)
            }
        case .crew:
            if let crewPerson = credit as? Crew{
                nameLabel.text = crewPerson.name
                characterJobLabel.text = "\(crewPerson.job) /  \(crewPerson.department)"
                profileIamgeView.kf.setImage(with: crewPerson.profileURL)
            }
        }
    }
    
}
