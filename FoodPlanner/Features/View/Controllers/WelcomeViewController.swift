//
//  ViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var router: Router
    
    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

