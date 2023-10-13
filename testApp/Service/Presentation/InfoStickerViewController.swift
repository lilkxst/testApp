//
//  ImageStickerViewController.swift
//  testApp
//
//  Created by Артём Костянко on 13.10.23.
//

import UIKit

protocol InfoStickerViewControllerProtocol: AnyObject {
    func updateInfo(sticker: StickerModel)
}

final class InfoStickerViewController: UIViewController, InfoStickerViewControllerProtocol {
    
    private var stickerInfo: StickerModel?
    
    // MARK: - Initial Views
    
    private lazy var stickerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "Sticker name: \n\(stickerInfo?.title ?? "")"
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
   private lazy var stickerRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "Sticker rating: \(stickerInfo?.rating ?? "")"
        label.textColor = .black
        return label
    }()
    
    private lazy var stickerURLLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "Sticker link: \n\(stickerInfo?.stickerURL ?? "")"
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private lazy var stickerUserNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "User: \(stickerInfo?.user ?? "")"
        label.textColor = .black
        return label
    }()
    
    private lazy var stickerImportDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "Date import: \(stickerInfo?.importDateTime ?? "")"
        label.textColor = .black
        return label
    }()
    
    // MARK: - InfoStickerViewControllerLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stickerNameLabel)
        view.addSubview(stickerRatingLabel)
        view.addSubview(stickerURLLabel)
        view.addSubview(stickerUserNameLabel)
        view.addSubview(stickerImportDateLabel)
    }
    
    private func setupConstraints() {
        stickerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stickerRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        stickerURLLabel.translatesAutoresizingMaskIntoConstraints = false
        stickerUserNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stickerImportDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stickerNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            stickerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stickerRatingLabel.topAnchor.constraint(equalTo: stickerNameLabel.bottomAnchor, constant: 20),
            stickerRatingLabel.leadingAnchor.constraint(equalTo: stickerNameLabel.leadingAnchor),
            stickerURLLabel.topAnchor.constraint(equalTo: stickerRatingLabel.bottomAnchor, constant: 20),
            stickerURLLabel.leadingAnchor.constraint(equalTo: stickerNameLabel.leadingAnchor),
            stickerUserNameLabel.topAnchor.constraint(equalTo: stickerURLLabel.bottomAnchor, constant: 20),
            stickerUserNameLabel.leadingAnchor.constraint(equalTo: stickerNameLabel.leadingAnchor),
            stickerImportDateLabel.topAnchor.constraint(equalTo: stickerUserNameLabel.bottomAnchor, constant: 20),
            stickerImportDateLabel.leadingAnchor.constraint(equalTo: stickerNameLabel.leadingAnchor)
        ])
    }
    
    func updateInfo(sticker: StickerModel) {
        stickerInfo = sticker
    }
}
