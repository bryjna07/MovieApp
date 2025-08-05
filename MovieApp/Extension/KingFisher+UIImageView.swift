//
//  KingFisher+UIImageView.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setKFImage(
        from url: URL?,
        placeholder: UIImage? = nil,
    ) {
        guard let url = url else {
            self.image = placeholder
            return
        }

        let processor = DownsamplingImageProcessor(size: self.bounds.size)

        let options: KingfisherOptionsInfo = [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(0.3)),
            .cacheOriginalImage
        ]

        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options
        ) { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
