//
//  StickerFactoryDelegate.swift
//  testApp
//
//  Created by Артём Костянко on 13.10.23.
//

import Foundation

protocol StickerFactoryDelegate: AnyObject {
    func didFailToLoad(with error: Error)
    func didReceiveNewStickers(sticker: [StickerModel])
}
