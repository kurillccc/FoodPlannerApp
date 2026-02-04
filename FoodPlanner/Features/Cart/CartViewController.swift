//
//  CartViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 02.02.2026.
//

import UIKit

final class CartViewController: UIViewController {

    private lazy var rootView: CartView = {
        let view = CartView()
        return view
    }()

    private var items: [CartItem] { CartManager.shared.items }

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        embedViews()
        setupDelegates()
        setupStyle()
        observeCart()
        updateTotal()
    }
    
}

// MARK: - Embed views

private extension CartViewController {
    
    func embedViews() {}
    
}

// MARK: - Setup Delegates

private extension CartViewController {
    
    func setupDelegates() {
        rootView.setDelegates(dataSource: self, delegate: self)
        rootView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.identifier)
        rootView.checkoutButton.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
    }
    
}

// MARK: - Setup style

private extension CartViewController {
    
    func setupStyle() {
        title = "Basket"
    }
    
}

// MARK: - Setup behavior

private extension CartViewController {
    
    func observeCart() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCart), name: .init("cartUpdated"), object: nil)
    }

    @objc func reloadCart() {
        rootView.reloadData()
        updateTotal()
    }

    func updateTotal() {
        let total = CartManager.shared.totalAmount()
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.currencyCode = "USD"
        rootView.setTotalText("Total: " + (nf.string(from: total as NSNumber) ?? ""))
    }

    @objc func checkoutTapped() {
        let alert = UIAlertController(title: "Checkout", message: "Total order placed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath)
        if let cell = cell as? CartItemCell {
            let item = items[indexPath.row]
            cell.configure(with: item)
        }
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

