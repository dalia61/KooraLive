//
//  MatchTableViewCell.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import UIKit
import Kingfisher

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var matchView: UIView!
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var isInFavoriteButton: UIButton!
    
    var isInFavorites: Bool = false
    var didAddMatch: (() -> ())?

    override func awakeFromNib() {
        self.matchView.layer.cornerRadius = 10
        self.matchView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(_ viewModel: MatchViewModel, didAddMatch: @escaping () -> ()) {
        self.didAddMatch = didAddMatch
        self.isInFavorites = viewModel.isInFavorites
        
        isInFavoriteButton.setImage(UIImage(systemName: (isInFavorites ? "star.fill" : "star")), for: .normal)
        
        team1Name.text = viewModel.homeTeamName
        team2Name.text = viewModel.awayTeamName
        
        guard let team1ImageURL = URL(string: viewModel.homeTeamcrest),
              let team2ImageURL = URL(string: viewModel.awayTeamcrest) else {
            team1Image.image = UIImage(named: "appIconTran")
            team2Image.image = UIImage(named: "appIconTran")
            return
        }
        
        team1Image.kf.setImage(with: team1ImageURL, placeholder: UIImage(named: "appIconTran"))
        team2Image.kf.setImage(with: team2ImageURL, placeholder: UIImage(named: "appIconTran"))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: viewModel.utcDate) else {
            print("Invalid date string")
            self.date.text = "Invalid date"
            self.time.text = "Invalid time"
            return
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: date)
        self.date.text = formattedDate.components(separatedBy: " ")[0]
        self.time.text = formattedDate.components(separatedBy: " ")[1]
        
        if Calendar.current.isDateInToday(date) || date > Date() {
            result.text = "VS"
            result.font = .boldSystemFont(ofSize: 18)
        } else {
            result.text = "\(viewModel.fullTime.homeTeam ?? 0) : \(viewModel.fullTime.awayTeam ?? 0)"
        }
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
        if let action = didAddMatch {
            action()
            isInFavoriteButton.setImage(UIImage(systemName: (!isInFavorites ? "star.fill" : "star")), for: .normal)
        }
    }
}
