//
//  MatchViewController.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import UIKit

class MatchViewController: UIViewController {
    private let presenter: MatchPresenter
    
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
        // Add your UI setup code here
    }
}
