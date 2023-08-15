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
    
    
    func setUpCellData(credit: Cast,type: CreditType){
        nameLabel.text = credit.name
        switch type{
        case .cast: characterJobLabel.text = "\(credit.character) / \(credit.department)"
        case .crew: characterJobLabel.text = "\(credit.job) /  \(credit.department)"
        }
        guard let urlPath = credit.profilePath, !urlPath.isEmpty,
              let url = URL(string: urlPath) else {
            profileIamgeView.image = UIImage(systemName: "person.fill")
            profileIamgeView.backgroundColor = .systemIndigo
            profileIamgeView.tintColor = .white
            return
        }
            profileIamgeView.kf.setImage(with: url)
     
    }
    
}
