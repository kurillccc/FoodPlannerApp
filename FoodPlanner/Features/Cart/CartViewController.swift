//
//  CartViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 02.02.2026.
//

import UIKit

final class CartViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let footerView = UIView()
    private let totalLabel = UILabel()
    private let checkoutButton = UIButton(type: .system)

    private var items: [CartItem] {
        CartManager.shared.items
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupDelegates()
        setupStyle()
        setupFooterStyle()
        observeCart()
        updateTotal()
        setupLayout()
        setupFooterLayout()
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
        checkoutButton.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
    }
    
}

// MARK: - Setup style

private extension CartViewController {
    
    func setupStyle() {
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        title = "Basket"
    }
    
    func setupFooterStyle() {
        footerView.backgroundColor = .secondarySystemBackground
        totalLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        totalLabel.textAlignment = .left
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
}

// MARK: - Setup behavior

private extension CartViewController {
    
    func observeCart() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCart), name: .init("cartUpdated"), object: nil)
    }

    @objc private func reloadCart() {
        tableView.reloadData()
        updateTotal()
    }
    
    func updateTotal() {
        let total = CartManager.shared.totalAmount()
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.currencyCode = "USD"
        totalLabel.text = "Total: " + (nf.string(from: total as NSNumber) ?? "")
    }
    
    @objc private func checkoutTapped() {
        let alert = UIAlertController(title: "Checkout", message: "Total order placed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
    
    func setupFooterLayout() {
        footerView.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(footerView)
        footerView.addSubview(totalLabel)
        footerView.addSubview(checkoutButton)

        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            totalLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            totalLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            checkoutButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            checkoutButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            footerView.heightAnchor.constraint(equalToConstant: 56)
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
        cell.backgroundColor = .systemBackground
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            CartManager.shared.remove(at: indexPath.row)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}

