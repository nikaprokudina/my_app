//
//  ViewController.swift
//  my_app
//
//  Created by Nika on 10/6/23.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPurple
        
        let url = URL(string: "https://www.freetogame.com/api/games?platform=pc" )! // ура плохой способ (может вернуть nil, но нам пофиг)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            // обработка данных
            let model = try! decoder.decode([GameDTO].self, from: data)
            //            let str = String(data: data, encoding: .utf8)
            //            print("Полученные данные: \(str ?? "")")
            print(model)
        }.resume()
        
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


