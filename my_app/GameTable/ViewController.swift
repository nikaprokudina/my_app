//
//  ViewController.swift
//  my_app
//
//  Created by Nika on 10/6/23.
//

import UIKit
import Foundation

final class GameTableViewController: UIViewController {
    private lazy var contentView: GameTableView = {
        let view = GameTableView()
        view.delegate = self
        return view
    }()
    
    private let service: GameServicing

    init(service: GameServicing) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        service.fetchGame { [self] games in
            DispatchQueue.main.async {
                self.contentView.configure(with: games)
            }
        }
    }
}

extension GameTableViewController: GameTableViewDelegate {
    func didSelectRow(_ gameModel: GameDTO) {
        let vc = GameDetailViewController()
        vc.gameModel = gameModel
        present(GameDetailViewController(), animated: true)
    }
}
