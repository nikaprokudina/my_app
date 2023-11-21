//
//  GameService.swift
//  my_app
//
//  Created by Nika on 11/21/23.
//

import Foundation

final class GameService{
    let decoder = JSONDecoder()
    let session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        return session
    }()
    
    func fetchBeer(completionHandler: @escaping ([GameDTO]) -> Void){
        
        let url = URL(string: "https://www.freetogame.com/api/games?platform=pc" )!
        session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil, let data = data else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            ///обработка данных
            let GameData = try! decoder.decode([GameDTO].self, from: data)
            completionHandler(GameData)
        }).resume()
    }
}

