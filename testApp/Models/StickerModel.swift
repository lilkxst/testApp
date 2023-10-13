//
//  GiphsModel.swift
//  testApp
//
//  Created by Артём Костянко on 12.10.23.
//

import Foundation
let url = "http://api.giphy.com/v1/stickers/trending?api_key=WtoBNaOPTCORQYOXshzQwN2pFHy8nYlq&limit=20"

struct StickersModel: Decodable {
    let stickers: [StickerModel]
    
    private enum CodingKeys: String, CodingKey {
        case stickers = "data"
    }
}

struct StickerModel: Decodable {
    let title: String
    let rating: String
    let stickerURL: String
    let user: String
    let importDateTime: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case rating = "rating"
        case stickerURL = "embed_url"
        case user = "username"
        case importDateTime = "import_datetime"
    }
}

