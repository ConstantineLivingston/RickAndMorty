//
//  CustomImageView.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import UIKit

final class CustomImageView: UIImageView {
    
    var imageURLString: String? {
        didSet {
            guard let imageURLString = imageURLString else { return }

            ImageProvider.downloadImageFrom(urlString: imageURLString) {
                [weak self] image in
                guard let self = self else { return }
                self.image = image
            }
        }
    }
    
    init(imageMode: UIImageView.ContentMode) {
        super.init(frame: .zero)
        contentMode = imageMode
        clipsToBounds = true
        layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
//        layer.cornerRadius = bounds.height / 2
    }

}
