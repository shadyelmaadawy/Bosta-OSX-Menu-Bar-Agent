//
//  SettingsViewController.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 01/12/2023.
//

import AppKit

final class SettingsViewController: BaseNSViewController, SettingsViewProtocol {
    
    // MARK: - Properties
    
    var presenter: SettingsPresenterProtocol!
     
    // MARK: - UI Components

    private lazy var appearanceView: BaseLabeledComboBox = {
        let baseView = BaseLabeledComboBox.init()
        baseView.setLabelTitle("Appearance:")
        return baseView
    }()
    
    private lazy var updateSettingsButton: PrimaryNSButton = {
        let baseButton = PrimaryNSButton.init()
        baseButton.setTitle("Update")
        return baseButton
    }()
    
    private lazy var copyRightLabel: BaseNSLabel = {
        let baseLabel = BaseNSLabel.init(.primary)
        baseLabel.alignment = .center
        baseLabel.maximumNumberOfLines = 2
        baseLabel.font = .getFont(.regular, textStyle: .footnote)
        baseLabel.setText("Copyright (©) 2023, Shady K. Maadawy\nAll rights reserved.")
        return baseLabel
    }()
 
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutSubViews()
        self.bindView()
    }
    
}

// MARK: - Binding Views

extension SettingsViewController {
    
    private func bindView() {
        
        self.updateSettingsButton.rx.tap
            .map({ [weak self] in
                guard let self = self else {
                    return 0
                }
                return self.appearanceView.viewComboBox.indexOfSelectedItem
        }).bind(to: presenter.updateButtonIsClicked)
        .disposed(by: disposeBag)
        
        presenter.appearancesItemsReady.subscribe(onNext: { [weak self] items in
            guard let self = self else {
                return
            }
            appearanceView.setComboItems(items.0)
            appearanceView.selectItem(at: Int(items.1))
            
        }).disposed(by: disposeBag)
        
        self.presenter.viewIsLoaded.accept(())
    }
}

// MARK: - Layout SubViews

extension SettingsViewController {
    
    private func layoutSubViews() {
        
        layoutAppearanceView()

        layoutCopyRightLabel()
        layoutUpdateSettingsButton()
        
    }
    
    private func layoutAppearanceView() {
        
        self.view.addSubview(appearanceView)
        
        let appearanceViewConstraints = [
            appearanceView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 8),
            appearanceView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 12),
            appearanceView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(appearanceViewConstraints)
    }
    
    private func layoutCopyRightLabel() {
        
        self.view.addSubview(copyRightLabel)
        
        let copyRightLabelConstraints = [
            copyRightLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            copyRightLabel.topAnchor.constraint(greaterThanOrEqualTo: appearanceView.bottomAnchor, constant: 16),
            copyRightLabel.topAnchor.constraint(greaterThanOrEqualTo: appearanceView.bottomAnchor, constant: 12),
            copyRightLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 24),
            copyRightLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -24)
        ]
        NSLayoutConstraint.activate(copyRightLabelConstraints)
        
    }
    
    private func layoutUpdateSettingsButton() {
        
        self.view.addSubview(updateSettingsButton)
        
        let updateSettingsButtonConstraints = [
            updateSettingsButton.topAnchor.constraint(equalTo: copyRightLabel.bottomAnchor, constant: 16),
            updateSettingsButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12),
            updateSettingsButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            updateSettingsButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
        ]
        NSLayoutConstraint.activate(updateSettingsButtonConstraints)
    }

}
