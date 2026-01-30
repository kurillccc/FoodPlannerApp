//
//  ViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private let welcomeView = WelcomeView()
    var router: Router?
    
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
        
        setup()
        layout()
    }
    
    func setup() {
        view.addSubview(welcomeView)
    }
    
    func layout() {
        welcomeView.pinToEdges(of: view)
    }

}


final class WelcomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
}

extension WelcomeView {
    
    private func setupView() {
        
    }
    
    private func style() {
        backgroundColor = .blue
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

#Preview {
    let vc = WelcomeViewController()
    return UINavigationController(rootViewController: vc)
}
