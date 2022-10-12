//
//  UIStackView+Extension.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 19.09.2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
