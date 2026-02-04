//
//  CartView.swift
//  FoodPlanner
//
//  Created by Кирилл on 03.02.2026.
//

import UIKit

final class CartView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    private lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        return label
    }()

    lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Checkout", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        embedViews()
        setupStyle()
        setupLayout()
        setupFooterLayout()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - Public

extension CartView {
    
    func setDelegates(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

    func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }

    func reloadData() {
        tableView.reloadData()
    }

    func setTotalText(_ text: String?) {
        totalLabel.text = text
    }
    
}

// MARK: - Embed views

private extension CartView {
    
    func embedViews() {
        addSubview(tableView)
        addSubview(footerView)
        footerView.addSubview(totalLabel)
        footerView.addSubview(checkoutButton)
    }
    
}

// MARK: - Setup style

private extension CartView {
    
    func setupStyle() {
        backgroundColor = .systemBackground
    }
    
}

// MARK: - Setup layout

private extension CartView {
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }

    func setupFooterLayout() {
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 56),

            totalLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            totalLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),

            checkoutButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            checkoutButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
    }
    
}
