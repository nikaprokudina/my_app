//
//  GameService.swift
//  my_app
//
//  Created by Nika on 11/21/23.
//

import Foundation

protocol GameServicing{
    func fetchGame(completionHandler: @escaping ([GameDTO]) -> Void)
}

final class GameService{
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    let session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        return session
    }()
    //обычно создают сессию отдельно, чтобы можно было настроить конфигурацию
}

extension GameService: GameServicing{
    func fetchGame(completionHandler: @escaping ([GameDTO]) -> Void){
        let url: URL = URL(string: "https://www.freetogame.com/api/games?platform=pc" )!
        session.dataTask(with: url, completionHandler:  { data, response, error in
            guard error == nil, let data = data else {
                return
            }
            
            //обработка данных
            let GameData = try! self.decoder.decode([GameDTO].self, from: data)
            completionHandler(GameData)

        }).resume()
        
    }
}




