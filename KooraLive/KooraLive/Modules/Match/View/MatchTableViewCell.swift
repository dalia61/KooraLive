//
//  MatchTableViewCell.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import UIKit
import Kingfisher

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var team2Name: UILabel!
    
    var didAddMatch: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(_ viewModel: MatchViewModel,
                   didAddMatch: @escaping () -> ()) {
        self.didAddMatch = didAddMatch
        
        team1Name.text = viewModel.homeTeamName
        team2Name.text = viewModel.awayTeamName
        result.text = "\(viewModel.fullTime.homeTeam ?? 0) : \(viewModel.fullTime.awayTeam ?? 0)"
        
        guard let team1ImageURL = URL(string: viewModel.homeTeamcrest) else {
            team1Image.image = UIImage(named: "AppIcon")
            return
        }

        guard let team2ImageURL = URL(string: viewModel.awayTeamcrest) else {
            team2Image.image = UIImage(named: "AppIcon")
            return
        }

        team1Image.kf.setImage(with: team1ImageURL, placeholder: UIImage(named: "AppIcon"))
        team2Image.kf.setImage(with: team2ImageURL, placeholder: UIImage(named: "AppIcon"))

                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: viewModel.utcDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: date)
            self.date.text = formattedDate.components(separatedBy: " ")[0]
            self.time.text = formattedDate.components(separatedBy: " ")[1]
        } else {
            print("Invalid date string")
            self.date.text = "Invalid date"
            self.time.text = "Invalid time"
        }
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
        if let action = didAddMatch {
            action()
        }
    }
}
