//
//  MatchViewController.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import UIKit

class MatchViewController: UIViewController {
    
    private let presenter: MatchInputProtocol
    private var favoriteMatches: [SavedMatchModel] = []

    @IBOutlet weak var matchesTableView: UITableView!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var scheduleBtn: UIButton!
    
    init(presenter: MatchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getRemoteMatches()
    }
    
    private func setupUI() {
        [favouriteBtn,
         scheduleBtn].map {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }

        setupTableView()
    }
    
    private func setupTableView() {
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        matchesTableView.registerCellNib(cellClass: MatchTableViewCell.self)
    }
    
    @IBAction func scheduleBtnTapped(_ sender: Any) {
        presenter.isShowingRemoteMatches = true
        updateButtonAppearance()
        presenter.getRemoteMatches()
    }
    
    @IBAction func favouriteBtnTapped(_ sender: Any) {
        presenter.isShowingRemoteMatches = false
        updateButtonAppearance()
        presenter.getFavouriteMatches()
    }

    private func updateButtonAppearance() {
        if presenter.isShowingRemoteMatches {
            scheduleBtn.backgroundColor = UIColor(named: "AccentColor")
            scheduleBtn.setTitleColor(UIColor(named: "grayCol"), for: .normal)
            favouriteBtn.backgroundColor = UIColor(named: "grayCol")
            favouriteBtn.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        } else {
            favouriteBtn.backgroundColor = UIColor(named: "AccentColor")
            favouriteBtn.setTitleColor(UIColor(named: "grayCol"), for: .normal)
            scheduleBtn.backgroundColor = UIColor(named: "grayCol")
            scheduleBtn.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        }
    }
}

extension MatchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        let sectionsCount = presenter.numberOfDays()
        if sectionsCount == 0 {
            matchesTableView.setEmptyMessage("No matches found")
        } else {
            matchesTableView.restore()
        }

        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textColor = UIColor(named: "RedCol")
        headerLabel.text = presenter.titleForSection(section: section)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfMatches(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        let viewModel = presenter.matchItem(section: indexPath.section, row: indexPath.row)
        cell.configure(viewModel) { [weak self] in
            self?.presenter.addMatch(section: indexPath.section, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension MatchViewController: MatchOutputProtocol {
    func reloadData() {
        matchesTableView.reloadData()
    }
}
