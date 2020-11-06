//
//  UIImageView+Extension.swift
//  FootballLeague
//
//  Created by Afnan on 11/5/20.
//

import UIKit
import Kingfisher
import SVGKit

extension UIImageView {

    func showImage(_ url: String?, _ defaultImage: UIImage = #imageLiteral(resourceName: "icons8-add-image-97")) {
        let main = URL(string: url ?? "")
        self.kf.indicator?.startAnimatingView()
        self.kf.indicatorType = .activity
        self.kf.setImage(with: main, options: [.processor(SVGImgProcessor())], completionHandler:   {[weak self] result in
            self?.kf.indicator?.stopAnimatingView()
            switch result {
            case .success:
//                self?.contentMode = .scaleToFill
                break
            case .failure:
                self?.contentMode = .scaleAspectFit
                self?.image = defaultImage
            }
        })
    }
}

public struct SVGImgProcessor:ImageProcessor {
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
