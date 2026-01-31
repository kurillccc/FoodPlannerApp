//
//  CategoriesView.swift
//  FoodPlanner
//
//  Created by Кирилл on 31.01.2026.
//

import UIKit

final class CategoriesView: UIView {
    
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

private extension CategoriesView {
    
    func embedViews() {
        addSubViews(
            
        )
    }
    
}

// MARK: - Setup style

private extension CategoriesView {
    
    func setupStyle() {
        
    }
    
}

// MARK: - Setup behavior

private extension CategoriesView {
    
    func setupBehavior() {
        
    }
    
}

// MARK: - Setup layout

private extension CategoriesView {

    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
}

#Preview {
    CategoriesView()
}
