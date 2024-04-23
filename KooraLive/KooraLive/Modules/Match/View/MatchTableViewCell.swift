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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(_ viewModel: MatchCellViewModel) {
        team1Nm.text = viewModel.homeTeamName
        team2Nm.text = viewModel.awayTeamName
        resulte.text = "\(viewModel.fullTime.homeTeam) \(viewModel.fullTime.awayTeam)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = dateFormatter.string(from: viewModel.utcDate)
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: date)
            // Set date and time labels
            self.date.text = formattedDate.components(separatedBy: " ")[0]
            self.time.text = formattedDate.components(separatedBy: " ")[1]
        } else {
            print("Invalid date string")
        }
    }
    
}
