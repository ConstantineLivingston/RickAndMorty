//
//  UICollectionViewCell+Extension.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
