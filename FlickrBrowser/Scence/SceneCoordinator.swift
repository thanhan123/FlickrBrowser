//
//  SceneCoordinator.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

enum TransitionType {
    case push
    case present
    case root
}

struct SceneCoordinator {
    private static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    private static func changeRootViewController(with vc: UIViewController) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = vc
        delegate.window?.makeKeyAndVisible()
    }
    
    static func showViewController(vc: UIViewController, typeTransition: TransitionType = .root) {
        switch typeTransition {
        case .root:
            changeRootViewController(with: vc)
        case .present:
            topViewController()?.present(vc, animated: true, completion: nil)
        case .push:
            topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
