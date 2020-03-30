//  GlobalFunction.swift
//  PartyMantra
//
//  Created by Subhash Kumar on 19/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import UIKit

class GlobalFunction {
    static let shared = GlobalFunction()
    
    func downloadImage(imageView: UIImageView, urlStr: String) {
        if let url = URL(string: urlStr ) {
        imageView.kf.setImage(with: url, placeholder: Constants.defaultUserImage) { result in
            // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
            switch result {
            case .success(let value):
                // The image was set to image view:
                print(value.image)

                // From where the image was retrieved:
                // - .none - Just downloaded.
                // - .memory - Got from memory cache.
                // - .disk - Got from disk cache.
                print(value.cacheType)

                // The source object which contains information like `url`.
                print(value.source)
                imageView.image = value.image

            case .failure(let error):
                print(error) // The error happens
                imageView.image = Constants.defaultUserImage
            }
        }
        } else {
            imageView.image = Constants.defaultUserImage
        }
    }
    
    
}



