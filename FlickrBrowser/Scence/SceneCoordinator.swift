//
//  SceneCoordinator.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

class SceneCoordinator: SceneCoordinatorType {
    
    private var currVC: UIViewController
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        currVC = window.rootViewController!
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }
    
    func transition(scene: Scene, typeTransition: TransitionType) {
        let destinationVC = scene.viewController()
        switch typeTransition {
        case .root:
            currVC = SceneCoordinator.actualViewController(for: destinationVC)
            window.rootViewController = destinationVC
        case .present:
            currVC.present(destinationVC, animated: true, completion: nil)
        case .push:
            let actualVC = SceneCoordinator.actualViewController(for: destinationVC)
            if let navVC = currVC.navigationController {
                navVC.pushViewController(actualVC, animated: true)
            }
        }
    }
}
