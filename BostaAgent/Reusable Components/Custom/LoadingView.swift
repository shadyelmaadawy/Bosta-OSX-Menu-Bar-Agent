//
//  LoadingView.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 07/12/2023.
//

import AppKit

final class BaseLoadingView: BaseNSView {
    
    // MARK: - UI Components
    
    private lazy var loadingIndicator: BaseNSProgressIndicator = {
        return BaseNSProgressIndicator.init()
    }()

    // MARK: - Initialization
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Configure

extension BaseLoadingView {
    
    override func configure() {
        super.configure()
        
        self.setBackgroundColor(.shadowColor.withAlphaComponent(0.6))
        
        self.layoutSubViews()
    }

}

// MARK: - Layout SubViews

extension BaseLoadingView {
    
    private func layoutSubViews() {
        self.layoutLoadingIndicator()
    }

    private func layoutLoadingIndicator() {
        
        self.addSubview(loadingIndicator)
        
        let loadingIndicatorConstraints = [
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIndicator.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 15),
            loadingIndicator.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -15),
            loadingIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 15),
            loadingIndicator.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(loadingIndicatorConstraints)

    }

}
