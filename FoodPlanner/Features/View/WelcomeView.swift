//
//  WelcomeView.swift
//  FoodPlanner
//
//  Created by Кирилл on 31.01.2026.
//

import UIKit

final class WelcomeView: UIView {
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: Images.Welcome.background)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView(image: Images.Welcome.logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        label.text = "Welcome to our Store"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "From store to door in just one hour"
        label.textColor = AppColor.Primary.description
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.layer.backgroundColor = AppColor.Primary.main.cgColor
        button.layer.cornerRadius = 16
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var didTapStart: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupStyle()
        setupBehavior()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
}

// MARK: - Embed views

private extension WelcomeView {
    
    func embedViews() {
        addSubViews(
            backgroundImage,
            logoView,
            titleLabel,
            descriptionLabel,
            startButton
        )
    }
    
}

// MARK: - Setup style

private extension WelcomeView {
    
    func setupStyle() {
        
    }
    
}

// MARK: - Setup behavior

private extension WelcomeView {
    
    func setupBehavior() {
        startButton
            .addTarget(
                self,
                action: #selector(startButtonSelector),
                for: .touchUpInside
            )
    }
    
    @objc func startButtonSelector() {
        didTapStart?()
    }
    
}

// MARK: - Setup layout

private extension WelcomeView {

    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoView.bottomAnchor
                .constraint(equalTo: titleLabel.topAnchor, constant: -40),
            
            titleLabel.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -40),
            titleLabel.bottomAnchor
                .constraint(equalTo: descriptionLabel.topAnchor, constant: -18),
            
            descriptionLabel.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor
                .constraint(equalTo: startButton.topAnchor, constant: -40),
            
            startButton.heightAnchor.constraint(equalToConstant: 67),
            startButton.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 30),
            startButton.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -30),
            startButton.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -90)
        ])
    }
    
}

#Preview {
    let vc = WelcomeViewController()
    return UINavigationController(rootViewController: vc)
}

