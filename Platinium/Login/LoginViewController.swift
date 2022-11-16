//
//  ViewController.swift
//  Platinium
//
//  Created by Mert Duran on 4.11.2022.
//

import UIKit
protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}
protocol LogoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let platiniumMessage = UILabel()
    let platiniumSubtitleMessage = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    //animation
    
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension LoginViewController {
    private func style() {
        
        platiniumMessage.translatesAutoresizingMaskIntoConstraints = false
        platiniumMessage.textAlignment = .center
        platiniumMessage.textColor = .systemCyan
        platiniumMessage.text = "Platinium"
        platiniumMessage.font = .systemFont(ofSize: 34, weight: .regular)
        platiniumMessage.adjustsFontForContentSizeCategory = true
        platiniumMessage.alpha = 0
        
        platiniumSubtitleMessage.translatesAutoresizingMaskIntoConstraints = false
        platiniumSubtitleMessage.textAlignment = .center
        platiniumSubtitleMessage.font = UIFont.preferredFont(forTextStyle: .title3)
        platiniumSubtitleMessage.adjustsFontForContentSizeCategory = true
        platiniumSubtitleMessage.numberOfLines = 0
        platiniumSubtitleMessage.text = "For those who live on Platinium standard"
        platiniumSubtitleMessage.textColor = .blue
        platiniumSubtitleMessage.alpha = 0
        
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 10
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(platiniumMessage)
        view.addSubview(platiniumSubtitleMessage)
        
        
        NSLayoutConstraint.activate([
            platiniumSubtitleMessage.topAnchor.constraint(equalToSystemSpacingBelow: platiniumMessage.bottomAnchor, multiplier: 3),
            platiniumMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        titleLeadingAnchor = platiniumMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: platiniumSubtitleMessage.bottomAnchor, multiplier: 6),
            platiniumSubtitleMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        subtitleLeadingAnchor = platiniumSubtitleMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
        
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor), //ortaya koyuyor
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            signInButton.bottomAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 6),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1)
            
        ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])

    }
}

extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username/Password Should Not Be Empty")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username/Password Cannot Be Empty")
            return
        }
        
//        if username == "Mert" && password == "Duran" {
//            signInButton.configuration?.showsActivityIndicator = true
//            delegate?.didLogin()
//        }else {
//            configureView(withMessage: "Incorrect Username/Password")
//
//        }
            
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0] //x positions.
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.35
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
}
extension LoginViewController {
    private func animate() {
        let duration = 1.5
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 0.75)
        
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.platiniumMessage.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.75)
        
        let animator4 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.platiniumSubtitleMessage.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator4.startAnimation(afterDelay: 0.75)
    }
    
   
}
