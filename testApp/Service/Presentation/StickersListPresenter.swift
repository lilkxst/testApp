//
//  StickersListPresenter.swift
//  testApp
//
//  Created by Артём Костянко on 13.10.23.
//

import Foundation

final class StickersListPresenter: StickerFactoryDelegate {
    
    private var stickerFactory: StickerFactoryProtocol?
    private var viewController: StickersListViewControllerProtocol?
    
    private var stickers: [StickerModel] = []
    
    init(viewController: StickersListViewControllerProtocol) {
        self.viewController = viewController
        
        stickerFactory = StickerFactory(stickerLoader: StickerLoader(), delegate: self)
        stickerFactory?.loadSticker()
    }
    
    func didFailToLoad(with error: Error) {
        let message = "\(error)"
        viewController?.showNetworkError(message: message)
    }
    
   func didReceiveNewStickers(sticker: [StickerModel]) {
       DispatchQueue.main.async {
           self.stickers = sticker
           self.viewController?.show(sticker: self.stickers)
       }
    }
    
    func reloadStickers() {
        stickerFactory?.loadSticker()
    }
}

