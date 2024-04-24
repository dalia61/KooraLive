//
//  MatchViewController.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import UIKit

class MatchViewController: UIViewController {
    
    private let presenter: MatchInputProtocol
    private var isShowingRemoteMatches = true
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
    }
    
    private func setupUI() {
        setupTableView()
        presenter.viewDidLoad()
    }
    
    private func setupTableView() {
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        matchesTableView.registerCellNib(cellClass: MatchTableViewCell.self)
    }
    
    @IBAction func scheduleBtnTapped(_ sender: Any) {
        showRemoteMatches()
    }
    
    @IBAction func favouriteBtnTapped(_ sender: Any) {
        showFavouriteMatches()
    }
    
    private func showFavouriteMatches() {
        isShowingRemoteMatches = false
        presenter.getFavouriteMatches()
        updateButtonAppearance()
    }
    
    private func showRemoteMatches() {
        isShowingRemoteMatches = true
        presenter.getRemoteMatches()
        updateButtonAppearance()
    }
    
    private func updateButtonAppearance() {
        if isShowingRemoteMatches {
            scheduleBtn.backgroundColor = UIColor(named: "#0B2740")
            scheduleBtn.setTitleColor(UIColor(named: "#F2F2F2"), for: .normal)
            favouriteBtn.backgroundColor = UIColor(named: "#F2F2F2")
            favouriteBtn.setTitleColor(UIColor(named: "#0B2740"), for: .normal)
        } else {
            scheduleBtn.backgroundColor = UIColor(named: "#F2F2F2")
            scheduleBtn.setTitleColor(UIColor(named: "#0B2740"), for: .normal)
            favouriteBtn.backgroundColor = UIColor(named: "#0B2740")
            favouriteBtn.setTitleColor(UIColor(named: "#F2F2F2"), for: .normal)
        }
    }
}

extension MatchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfDays()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textColor = UIColor(named: "#E2362C")
        headerLabel.text = presenter.titleForSection(section: section)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
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
        return 100
    }
}

extension MatchViewController: MatchOutputProtocol {
    func reloadData() {
        if isShowingRemoteMatches {
            matchesTableView.reloadData()
        } else {
            //favoriteMatches = presenter.getFavouriteMatches()
            matchesTableView.reloadData()
        }
    }
}
