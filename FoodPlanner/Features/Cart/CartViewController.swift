//
//  CartViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 02.02.2026.
//

import UIKit

final class CartViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private var items: [CartItem] {
        CartManager.shared.items
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupDelegates()
        setupStyle()
        observeCart()
        setupLayout()
    }
    
}

// MARK: - Embed views

private extension CartViewController {
    
    func embedViews() {
        view.addSubview(tableView)
    }
    
}

// MARK: - Setup Delegates

private extension CartViewController {
    
    func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
}

// MARK: - Setup style

private extension CartViewController {
    
    func setupStyle() {
        view.backgroundColor = .systemBackground
        title = "Basket"
    }
    
}

// MARK: - Setup behavior

private extension CartViewController {
    
    func observeCart() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCart), name: .init("cartUpdated"), object: nil)
    }

    @objc private func reloadCart() {
        tableView.reloadData()
    }
    
}

// MARK: - Setup layout

private extension CartViewController {

    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        var content = UIListContentConfiguration.subtitleCell()
        content.text = item.product.title
        if let price = item.product.price {
            let nf = NumberFormatter()
            nf.numberStyle = .currency
            nf.currencyCode = "USD"
            content.secondaryText = "Qty: \(item.quantity)  •  \(nf.string(from: price as NSNumber) ?? "")"
        } else {
            content.secondaryText = "Qty: \(item.quantity)"
        }
        content.image = item.product.image
        content.imageProperties.maximumSize = CGSize(width: 40, height: 40)
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {}

