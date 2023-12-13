//
//  TrackerViewController.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 29/11/2023.
//

import AppKit

final class TrackerViewController: BaseNSViewController, TrackerViewProtocol {
    
    // MARK: - Properties
    
    var presenter: TrackerPresenterProtocol!
    
    // MARK: - UI Components

    private lazy var trackingNumberLabel: BaseNSLabel = {
        let baseLabel = BaseNSLabel.init(.secondary)
        baseLabel.font = .getFont(.regular, textStyle: .footnote)
        return baseLabel
    }()
  
    private lazy var trackStatusLabel: BaseNSLabel = {
        let baseLabel = BaseNSLabel.init(.accentColor)
        baseLabel.font = .getFont(.semiBold, textStyle: .title2)
        baseLabel.setText("Loading")
        return baseLabel
    }()
    
    private lazy var lastUpdateLabel: BaseNSLabel = {
        let baseLabel = BaseNSLabel.init(.secondary)
        baseLabel.font = .getFont(.regular, textStyle: .caption2)
        return baseLabel
    }()
    
    private lazy var refreshButton: TransparentNSButton = {
        let baseButton = TransparentNSButton.init()
        baseButton.setImage(.refresh, withColor: .accent)
        return baseButton
    }()
    
    private lazy var statusDivider: AppKitBridge = {
        return AppKitBridge.init(rootView: SwiftUIDivider.init())
    }()
}

// MARK: - User Interface Events

extension TrackerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubViews()
        bindView()
    }
    
}

// MARK: - Binding Views

extension TrackerViewController {
    
    private func bindView() {
        
        presenter.trackingNumberBuffer
        .bind(to: self.trackingNumberLabel.rx.text)
        .disposed(by: disposeBag)
        
        presenter.trackStatusBuffer
        .bind(to: self.trackStatusLabel.rx.text)
        .disposed(by: disposeBag)

        presenter.lastUpdateBuffer
        .bind(to: self.lastUpdateLabel.rx.text)
        .disposed(by: disposeBag)

        self.refreshButton.rx.tap
            .bind(to: presenter.refreshButtonClicked)
            .disposed(by: disposeBag)
        
        self.presenter.viewIsLoaded.accept(())

    }
}


// MARK: - Layout SubViews

extension TrackerViewController {
    
    private func layoutSubViews() {
        
        layoutTrackingNoLabel()
        layoutTrackStatusLabel()
        layoutLastUpdateConstraints()
        layoutRefreshButton()
        layoutStatusDivider()
        
    }
    
    private func layoutTrackingNoLabel() {
        
        self.view.addSubview(trackingNumberLabel)
        
        let trackingNoLabelConstraints = [
            trackingNumberLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            trackingNumberLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
        ]
        NSLayoutConstraint.activate(trackingNoLabelConstraints)
        
    }
    
    private func layoutTrackStatusLabel() {
        
        self.view.addSubview(trackStatusLabel)
        
        let trackStatusLabelConstraints = [
            trackStatusLabel.topAnchor.constraint(equalTo: trackingNumberLabel.bottomAnchor),
            trackStatusLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
        ]
        NSLayoutConstraint.activate(trackStatusLabelConstraints)
        
    }
    
    private func layoutLastUpdateConstraints() {
        
        self.view.addSubview(lastUpdateLabel)
        
        let lastUpdateLabelConstraints = [
            lastUpdateLabel.topAnchor.constraint(equalTo: trackStatusLabel.bottomAnchor),
            lastUpdateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
        ]
        NSLayoutConstraint.activate(lastUpdateLabelConstraints)
        
    }
    
    private func layoutRefreshButton() {
        self.view.addSubview(refreshButton)
        
        let refreshButtonConstraints = [
            refreshButton.centerYAnchor.constraint(equalTo: trackStatusLabel.centerYAnchor),
            refreshButton.leadingAnchor.constraint(equalTo: lastUpdateLabel.trailingAnchor, constant: 12),
            refreshButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
        ]
        NSLayoutConstraint.activate(refreshButtonConstraints)
        
    }
    
    private func layoutStatusDivider() {
        
        self.view.addSubview(statusDivider)
        
        let statusDividerConstraints = [
            statusDivider.topAnchor.constraint(equalTo: lastUpdateLabel.bottomAnchor, constant: 8),
            statusDivider.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12),
            statusDivider.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            statusDivider.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(statusDividerConstraints)
        
    }
        
}
