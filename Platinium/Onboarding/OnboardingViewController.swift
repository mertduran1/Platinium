//
//  OnboardingViewController.swift
//  Platinium
//
//  Created by Mert Duran on 6.11.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    let imageView = UIImageView()
    
    let pixelImageName : String
    let titleText: String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        style()
        layout()
    }
    
    init(pixelImageName: String, titleText: String) {
        self.pixelImageName = pixelImageName
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: pixelImageName)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = titleText
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        
    }
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}
