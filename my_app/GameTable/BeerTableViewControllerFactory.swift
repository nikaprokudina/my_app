//
//  GameTableViewControllerFactory.swift
//  my_app
//
//  Created by Nika on 11/21/23.
//

import Foundation

final class GameTableViewControllerFactory{
    func build() -> GameTableViewController{
        let service = GameService()
        let viewController = GameTableViewController(service: service)
        return viewController
    }
}
