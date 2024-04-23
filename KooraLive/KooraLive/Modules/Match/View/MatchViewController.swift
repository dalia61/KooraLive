//
//  MatchViewController.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import UIKit

class MatchViewController: UIViewController {
    
    private let presenter: MatchInputProtocol
    
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
}

extension MatchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfDays()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.titleForSection(section: section)
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
        return 200
    }
}

extension MatchViewController: MatchOutputProtocol {
    func reloadData() {
        matchesTableView.reloadData()
    }
}
