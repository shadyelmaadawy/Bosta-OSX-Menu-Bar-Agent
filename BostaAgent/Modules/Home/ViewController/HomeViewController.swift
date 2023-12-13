//
//  HomeViewController.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 28/11/2023.
//

import AppKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseNSViewController, HomeViewProtocol {
    
    // MARK: - Properties

    var presenter: HomePresenterProtocol!

    // MARK: - UI Components
    
    private lazy var searchTextField: NumericNSTextField = {
        let baseTextField = NumericNSTextField.init()
        baseTextField.setPlaceHolder("Tracking Number:")
        return baseTextField
    }()
    
    private lazy var searchButton: PrimaryNSButton = {
        let baseButton = PrimaryNSButton.init()
        baseButton.setImage(.search, withColor: .white)
        return baseButton
    }()
    
    private lazy var bottomBarDivider: AppKitBridge = {
        return AppKitBridge.init(rootView: SwiftUIDivider.init())
    }()
    
    private lazy var settingsButton: TransparentNSButton = {
        let baseButton = TransparentNSButton.init()
        baseButton.setImage(.settings)
        return baseButton
    }()
    
    private lazy var exitButton: TransparentNSButton = {
        let baseButton = TransparentNSButton.init()
        baseButton.setImage(.exit)
        return baseButton
    }()

}

// MARK: - User Interface Events

extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubViews()
        bindView()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.searchTextField.stringValue = ""
        self.searchTextField.resignFirstResponder()
    }
}

// MARK: - Binding Views

extension HomeViewController {
    
    private func bindView() {
        
        self.searchTextField
            .rx.text.orEmpty
            .map({$0.count > 0 && $0.isValidNumeric})
            .asDriver(onErrorJustReturn: false)
            .drive(searchButton.rx.isEnabled)
            .disposed(by: disposeBag)
        self.searchTextField.rx.text.orEmpty
            .map({$0.numeric})
            .asDriver(onErrorJustReturn: nil)
            .drive(presenter.shipmentNumber)
            .disposed(by: disposeBag)
        
        self.searchButton.rx.tap
            .bind(to: presenter.searchButtonClicked)
            .disposed(by: disposeBag)
        
        self.settingsButton.rx.tap
            .bind(to: presenter.settingsButtonClicked)
            .disposed(by: disposeBag)
        self.exitButton.rx.tap
            .bind(to: presenter.exitButtonClicked)
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Layout SubViews

extension HomeViewController {
    
    private func layoutSubViews() {

        layoutSearchTextField()
        layoutSearchButton()
        
        layoutBottomBarDivider()
        layoutSettingsButton()
        layoutExitButton()
    }
    
    private func layoutSearchTextField() {
        
        self.view.addSubview(searchTextField)

        let searchTextFieldConstraints = [
            searchTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            searchTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
        ]
        NSLayoutConstraint.activate(searchTextFieldConstraints)
    }
    
    private func layoutSearchButton() {
        
        self.view.addSubview(searchButton)
        
        let searchButtonConstraints = [
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchButton.topAnchor.constraint(greaterThanOrEqualTo: safeArea.topAnchor, constant: 24),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 12),
            searchButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(searchButtonConstraints)

    }
    
    private func layoutBottomBarDivider() {
        
        self.view.addSubview(bottomBarDivider)
        
        let bottomBarDividerConstraints = [
            bottomBarDivider.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
            bottomBarDivider.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            bottomBarDivider.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(bottomBarDividerConstraints)
        
    }
    
    private func layoutSettingsButton() {
        
        self.view.addSubview(settingsButton)
        
        let settingsButtonConstraints = [
            settingsButton.topAnchor.constraint(equalTo: bottomBarDivider.bottomAnchor, constant: 8),
            settingsButton.heightAnchor.constraint(equalToConstant: 24),
            settingsButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            settingsButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 4),
        ]
        NSLayoutConstraint.activate(settingsButtonConstraints)
        
    }
    
    private func layoutExitButton() {
        
        self.view.addSubview(exitButton)
        
        let exitButtonConstraints = [
            exitButton.topAnchor.constraint(equalTo: bottomBarDivider.bottomAnchor, constant: 8),
            exitButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            exitButton.leadingAnchor.constraint(greaterThanOrEqualTo: settingsButton.trailingAnchor, constant: 8),
            exitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -4)
        ]
        NSLayoutConstraint.activate(exitButtonConstraints)
    }
}
