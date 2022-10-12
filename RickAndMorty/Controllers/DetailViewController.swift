//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 19.09.2022.
//

import UIKit

final class DetailViewController: ViewController {
    
    private let infoLabel = UILabel()
    private let imageView = CustomImageView(imageMode: .scaleAspectFill)
    private let stackView = UIStackView()
    
    var object: CharacterObject? {
        didSet {
            guard let character = object else { return }
            navigationItem.title = character.name
            updateDetailsWith(character)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
    
    override func configureViews() {
        view.backgroundColor = .secondarySystemBackground
                
        infoLabel.font = UIFont(name: "ChristmasGladness", size: 25)
        infoLabel.numberOfLines = 0
        infoLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func constrainViews() {
        view.addConstrainedSubviews(imageView,
                                    infoLabel)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

    }
    
    private func updateDetailsWith(_ object: CharacterObject) {
        let string = """
        Name: \(object.name)
        Status: \(object.status.rawValue)
        Species: \(object.species)
        Gender: \(object.gender.rawValue)
        Origin: \(object.origin.name)
        Location: \(object.location.name)
        """
        infoLabel.text = string
        imageView.imageURLString = object.image
    }
}
