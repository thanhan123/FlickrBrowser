//
//  Scence.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation
import UIKit

enum Scene {
    case photos(ListPhotoViewModel)
    case photoDetails(PhotoDetailsViewModel)
}

extension Scene {
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch self {
            
        case .photos(let viewModel):
            let nc = storyboard.instantiateViewController(withIdentifier:
                "ListPhotos") as! UINavigationController
            var vc = nc.viewControllers.first as! ListPhotoViewController
            vc.bindViewModel(to: viewModel)
            return nc
            
        case .photoDetails(let viewModel):
            var vc = storyboard.instantiateViewController(withIdentifier: "PhotoDetailsViewController") as! PhotoDetailsViewController
            vc.bindViewModel(to: viewModel)
            return vc
        }
    }
}
