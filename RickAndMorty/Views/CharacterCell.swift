//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    private let imageView = CustomImageView(imageMode: .scaleAspectFill)
    private let characterNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        constrainViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        backgroundColor = .black.withAlphaComponent(0.8)
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        
        characterNameLabel.text = "Character Name"
        characterNameLabel.textAlignment = .center
        characterNameLabel.font = UIFont.systemFont(ofSize: 18)
        characterNameLabel.textColor = UIColor.white
        characterNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func constrainViews() {
        addConstrainedSubviews(imageView,
                               characterNameLabel)
        
        NSLayoutConstraint.activate([
            characterNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            imageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
    }
    
    func setData(with object: CharacterObject) {
        characterNameLabel.text = object.name
        imageView.imageURLString = object.image
    }
}
