//
//  BaseLabeledComboBox.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 03/12/2023.
//

import AppKit

final class BaseLabeledComboBox: BaseNSView {
    
    // MARK: - UI Components
    
    private lazy var viewLabel: BaseNSLabel = {
        let baseLabel = BaseNSLabel.init(.primary)
        baseLabel.font = .getFont(.regular, textStyle: .footnote)
        return baseLabel
    }()
    
    private(set) lazy var viewComboBox: BaseNSComboBox = {
        let baseComboBox = BaseNSComboBox.init()
        baseComboBox.setContentHuggingPriority(.defaultLow, for: .vertical)
        return baseComboBox
    }()

    // MARK: - Initialization

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure

extension BaseLabeledComboBox {
    
    override func configure() {
        super.configure()
        
        layoutSubViews()
    }
}

// MARK: - Operations

extension BaseLabeledComboBox {

    func setLabelTitle(_ textString: String) {
        self.viewLabel.setText(textString)
    }
    
    func setComboItems(_ items: [Any]) {
        self.viewComboBox.removeAllItems()
        self.viewComboBox.addItems(withObjectValues: items)
    }
    
    func selectItem(at index: Int) {
        self.viewComboBox.selectItem(at: index)
    }
    
}

// MARK: - Layout SubViews

extension BaseLabeledComboBox {
    
    private func layoutSubViews() {
        
        layoutViewLabel()
        layoutViewComboBox()
    }

    private func layoutViewLabel() {
        
        self.addSubview(viewLabel)
        
        let viewLabelConstraints = [
            viewLabel.topAnchor.constraint(equalTo: self.topAnchor),
            viewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            viewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        NSLayoutConstraint.activate(viewLabelConstraints)
        
    }
    
    private func layoutViewComboBox() {
        
        self.addSubview(viewComboBox)
        
        let viewComboConstraints = [
            viewComboBox.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 8),
            viewComboBox.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewComboBox.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewComboBox.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        NSLayoutConstraint.activate(viewComboConstraints)
    }
}

