//
//  CategoriesViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 31.01.2026.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    private var router: Router?
    
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
        
        view.backgroundColor = .systemBackground
    }
    
}

#Preview {
    let vc = CategoriesViewController()
    return UINavigationController(rootViewController: vc)
}
