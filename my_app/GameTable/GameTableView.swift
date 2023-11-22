//
//  GameTableView.swift
//  my_app
//
//  Created by Nika on 11/21/23.
//

import Foundation
import UIKit

protocol GameTableViewDelegate {
    func didSelectRow(_ game: GameDTO)
}

final class GameTableView: UIView, UITableViewDataSource { // Change inheritance to UIView and add UITableViewDataSource

    private lazy var tableView: UITableView = {
        let tableView = UITableView() // разные tableView
        tableView.dataSource = tableManager // Make sure to conform to UITableViewDataSource
        tableView.delegate = tableManager
        return tableView
    }()
    
    private lazy var spinnerView = UIActivityIndicatorView(style: .large)
    private lazy var tableManager = GameTableManager()
    var delegate: GameTableViewDelegate? //делегат
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        tableManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .systemMint
        addSubviews()
        makeConstraints()
        spinnerView.startAnimating()
    }
    
    func configure(with viewModel: [GameDTO]){
        tableManager.tableData = viewModel
        spinnerView.stopAnimating()
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//реализация делегата
extension GameTableView: GameTableManagerDelegate {
    func didSelectRow(_ gameModel: GameDTO) {
        delegate?.didSelectRow(gameModel)
    }
}

// MARK: - Private

private extension GameTableView {
    func addSubviews(){
        [tableView, spinnerView].forEach { addSubview($0) }
    }
    
    func makeConstraints(){
        [tableView, spinnerView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([ // вёрстка
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor), // учитывать камеру итд
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            spinnerView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
}
