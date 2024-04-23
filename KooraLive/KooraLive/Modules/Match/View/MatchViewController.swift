//
//  MatchViewController.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import UIKit

class MatchViewController: UIViewController {
    
    private let presenter: MatchPresenter
    private var matches: [MatchCellViewModel] = []
    
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
        setupTableView()
        presenter.fetchMatches()
    }
    
    private func setupTableView() {
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        matchesTableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
    }
}

extension MatchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchTableViewCell
        cell.configure(matches[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension MatchViewController: MatchOutputProtocol {
    func matchesResult(match: [Match]) {
        matches = match.map { MatchCellViewModel(match: $0) }
        matchesTableView.reloadData()
    }
}
