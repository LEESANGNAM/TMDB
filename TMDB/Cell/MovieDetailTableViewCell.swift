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
    
    
    func setUpCellData(credit: MoviePeople){
        nameLabel.text = credit.name
        if credit.profileString != "" {
            profileIamgeView.kf.setImage(with: credit.profileURL)
        }else{
            profileIamgeView.image = UIImage(systemName: "person.fill")
            profileIamgeView.backgroundColor = .systemIndigo
            profileIamgeView.tintColor = .white
        }
        switch credit.group{
        case .cast:
            if let castPerson = credit as? Cast{
                characterJobLabel.text = "\(castPerson.character) / \(castPerson.department)"
            }
        case .crew:
            if let crewPerson = credit as? Crew{
                characterJobLabel.text = "\(crewPerson.job) /  \(crewPerson.department)"
            }
        }
    }
    
}
