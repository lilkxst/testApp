//
//  StickerFactory.swift
//  testApp
//
//  Created by Артём Костянко on 13.10.23.
//

import Foundation

protocol StickerFactoryProtocol {
    func loadSticker()
}

final class StickerFactory: StickerFactoryProtocol {
   
    private let stickerLoader: StickerLoaderProtocol
    weak var delegate: StickerFactoryDelegate?
    private var stickers: [StickerModel] = []
    
    init(stickerLoader: StickerLoaderProtocol, delegate: StickerFactoryDelegate?) {
        self.stickerLoader = stickerLoader
        self.delegate = delegate
    }
    
    func loadSticker() {
        stickerLoader.loadStickers { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                    switch result {
                    case .success(let stickersModel):
                        self.stickers = stickersModel.stickers
                        //print(self.stickers)
                        self.delegate?.didReceiveNewSticker(sticker: self.stickers)
                        //self.delegate?.didLoadDataFromService()
                    case .failure(let error):
                        self.delegate?.didFailToLoad(with: error)
                }
            }
        }
    }
}

