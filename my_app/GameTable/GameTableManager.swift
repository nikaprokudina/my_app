//
//  GameTableManager.swift
//  my_app
//
//  Created by Nika on 11/21/23.
//

import Foundation
import UIKit

// MARK: - BeerTableManagerDelegate
protocol BeerTableManagerDelegate: AnyObject {
    func didSelectRow(_ beerModel: BeerDTO)
}

final class GameTableManager: NSObject{
     var delegate: BeerTableManagerDelegate? //делегат
    var tableData: [GameDTO] = []
}

// MARK: - UITableViewDataSource

//добавить функционал уже существующим штукам
extension GameTableManager: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:
                   Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = tableData[indexPath.row]
        var cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        // configuration.image = UIImage()
        configuration.text = game.title
        configuration.secondaryText = game.short_description
        cell.contentConfiguration = configuration
        return cell
    }
}

//расширение
extension GameTableManager: UITableViewDelegate{
    //в момент нажатия на таблицу
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //анимация тап
        let game = tableData[indexPath.row]
        delegate?.didSelectRow(game)
    }
    
}
