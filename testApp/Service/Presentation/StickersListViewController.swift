//
//  ViewController.swift
//  testApp
//
//  Created by Артём Костянко on 12.10.23.
//

import UIKit

protocol StickersListViewControllerProtocol: AnyObject {
    func showNetworkError(message: String)
    func show(sticker: [StickerModel])
}

final class StickersListViewController: UIViewController, StickersListViewControllerProtocol {
    
    private weak var delegate: InfoStickerViewControllerProtocol?
    private var stickerFactory: StickerFactoryProtocol?
    private var presenter: StickersListPresenter!
    private var stickers: [StickerModel] = []
    
    // MARK: - Views Initial
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Top twenty stickers for today"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var stickerListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 75
        tableView.layer.cornerRadius = 16
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - ViewControllerLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = StickersListPresenter(viewController: self)
        setupViews()
        setupConstraints()
    }
    
    
    // MARK: - SetupViews
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(stickerListTableView)
        stickerListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "StickersListTableViewCell")
    }
    
    // MARK: = SetupConstraints
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        stickerListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stickerListTableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 35),
            stickerListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stickerListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            stickerListTableView.heightAnchor.constraint(equalToConstant: 650)
        ])
    }
    
    func show(sticker: [StickerModel]) {
        self.stickers = sticker
        stickerListTableView.reloadData()
    }

    func showNetworkError(message: String) {
        let model = AlertModel(title: "Не удалось загрузить данные",
                               message: message,
                               buttonText: "Попробовать ещё раз") { [weak self] in guard let self = self else { return }
            self.presenter.reloadStickers()
        }
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            self.presenter.reloadStickers()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension StickersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StickersListTableViewCell", for: indexPath)
        cell.backgroundColor = .lightGray
        cell.textLabel?.text = "\(stickers[indexPath.row].title)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StickersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoStickersViewController = InfoStickerViewController()
        self.delegate = infoStickersViewController
        let navigationController = UINavigationController(rootViewController: infoStickersViewController)
        self.delegate?.updateInfo(sticker: stickers[indexPath.row])
        present(navigationController, animated: true)
    }
}

