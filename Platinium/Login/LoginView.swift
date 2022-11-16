//
//  LoginView.swift
//  Platinium
//
//  Created by Mert Duran on 4.11.2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    let stackView = UIStackView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented yet!")
    }
    
}
extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = true
        backgroundColor = .secondarySystemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.enablePasswordToggle()
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .lightGray
        
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
    func layout() {
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
        trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
        bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
        dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
//        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

extension LoginView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
      return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
