//
//  CustomButton.swift
//  UserDefaultsTextTry
//
//  Created by Александр on 03.10.2022.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: - inits
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        setSelfButton(title: title, color: color)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not be implemented")
    }
    
    // MARK: - override methods
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
    }
    
    func setSelfButton(title: String, color: UIColor) {
        backgroundColor = color
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.white, for: .normal)
    }
}
