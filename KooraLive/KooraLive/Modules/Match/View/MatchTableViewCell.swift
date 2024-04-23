//
//  MatchTableViewCell.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var team1Img: UIImageView!
    @IBOutlet weak var team1Nm: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var resulte: UILabel!
    @IBOutlet weak var team2Img: UIImageView!
    @IBOutlet weak var team2Nm: UILabel!
    
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

        team1Nm.text = viewModel.homeTeamName
        team2Nm.text = viewModel.awayTeamName
        resulte.text = "\(viewModel.fullTime.homeTeam ?? 0) : \(viewModel.fullTime.awayTeam ?? 0)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: viewModel.utcDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: date)
//             Set date and time labels
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
