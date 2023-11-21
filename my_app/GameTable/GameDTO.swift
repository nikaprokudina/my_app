//
//  BeerModel.swift
//  my_app
//
//  Created by Nika on 11/21/23.
//

import Foundation

struct GameDTO: Decodable {
    let id: Int
    let title: String
    let short_description: String?
    let thumbnail: URL? //картинка

    enum CodingKeys: String, CodingKey {
        case id, title, short_description, thumbnail = "image_url"
    }
}
