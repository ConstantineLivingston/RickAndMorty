//
//  ImageProvider.swift
//  RickAndMorty
//
//  Created by Konstantin Bratchenko on 14.09.2022.
//

import Foundation
import UIKit

final class ImageProvider {
    static let imageCache = NSCache<NSString, AnyObject>()
    
    static func downloadImageFrom(urlString: String, withCompletion completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, withCompletion: completion)
    }
    
    static func downloadImageFrom(url: URL, withCompletion completion: @escaping (UIImage) -> Void) {
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            completion(imageFromCache)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("URLSession Task Failed: %@", error!.localizedDescription)
                    return
                }
                
                guard let data = data else { return }

                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(imageToCache)
                }
            }.resume()
        }

    }
}
