//
//  UIView+Extension.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import UIKit

extension UIView {
    func addConstrainedSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func addConstrainedSubviews(_ views: UIView...) {
        views.forEach { addConstrainedSubview($0) }
    }
}
