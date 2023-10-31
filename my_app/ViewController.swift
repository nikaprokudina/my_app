//
//  ViewController.swift
//  my_app
//
//  Created by Nika on 10/6/23.
//

import UIKit

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < GameData.count else {
            return UITableViewCell()
        }
        
        let game = GameData[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = game.title
        cell.detailTextLabel?.text = game.short_description
        return cell
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView() // разные tableView
        tableView.backgroundColor = .cyan
        tableView.dataSource = self
        return tableView
    }()
    
    private var GameData: [GameDTO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ // вёрстка
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor), // учитывать камеру итд
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let url = URL(string: "https://www.freetogame.com/api/games?platform=pc" )! // ура плохой способ (может вернуть nil, но нам пофиг)
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil, let data = data else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            ///обработка данных
            self.GameData = try! decoder.decode([GameDTO].self, from: data)
            DispatchQueue.main.async { // сахар, а так можно некрасиво: DispatchQueue.main.async(execute: {}
                self.tableView.reloadData()
            }
        }).resume()
        
    }
    
    struct GameDTO: Decodable {
        let id: Int
        let title: String
        let short_description: String?
        let thumbnail: URL? //картинка

        enum CodingKeys: String, CodingKey {
            case id, title, short_description, thumbnail = "image_url"
        }
    }
}


