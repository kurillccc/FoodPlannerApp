//
//  ViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private let welcomeView = WelcomeView()
    private let router: Router?
    
    convenience init() {
        self.init(router: nil)
    }
    
    init(router: Router?) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupLayout()
    }

}

// MARK: - Embed views

private extension WelcomeViewController {
    
    func embedViews() {
        view.addSubview(welcomeView)
        welcomeView.didTapStart = { [weak self] in
            guard let self = self else { return }
            self.router?.pushCategoriesViewController()
        }
    }
    
}

// MARK: - Setup layout

private extension WelcomeViewController {
    
    func setupLayout() {
        welcomeView.pinToEdges(of: view)
    }
    
}
