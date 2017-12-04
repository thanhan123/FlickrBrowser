//
//  SceneCoordinator.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

class SceneCoordinator: SceneCoordinatorType {
//    private static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return topViewController(nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return topViewController(presented)
//        }
//        return base
//    }
    
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
