//
//  GiphsLoader.swift
//  testApp
//
//  Created by Артём Костянко on 12.10.23.
//

import UIKit

protocol StickerLoaderProtocol {
    func loadStickers(handler: @escaping (Result<StickersModel, Error>) -> Void)
}

struct StickerLoader: StickerLoaderProtocol {
    private let networkClient: NetworkRouting
    
    init(networkClient: NetworkRouting = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    private var stickersURL: URL {
        guard let url = URL(string: "http://api.giphy.com/v1/stickers/trending?api_key=WtoBNaOPTCORQYOXshzQwN2pFHy8nYlq&limit=20") else {
            preconditionFailure("Problem with URL")
        }
        return url
    }
    
    func loadStickers(handler: @escaping (Result<StickersModel, Error>) -> Void) {
        networkClient.fetch(url: stickersURL) { result in
            switch result {
            case .success(let data):
                do {
                    let sticker = try JSONDecoder().decode(StickersModel.self, from: data)
                    handler(.success(sticker))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
