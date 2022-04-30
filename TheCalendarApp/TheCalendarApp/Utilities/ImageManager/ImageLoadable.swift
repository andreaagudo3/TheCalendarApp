//
//  ImageLoadable.swift
//  CalendarApp
//
//  Created by Andrea Agudo on 18/4/22.
//

import UIKit

protocol ImageLoadable: AnyObject {
    func loadImage(url: URL, into: UIImageView, placeHolder: UIImage?)
}

extension UIView: ImageLoadable {
    func loadImage(url: URL, into: UIImageView, placeHolder: UIImage? = UIImage(named: "placeholder")) {
        DispatchQueue.main.async {
            let options = ImageManager.createImageLoadingOptions(placeHolder: placeHolder,
                                                                 transition: .fadeIn(duration: 0.5))
            ImageManager.loadImage(with: url, options: options, into: into)
        }
    }
}

