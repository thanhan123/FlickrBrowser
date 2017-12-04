//
//  SceneCoordinatorType.swift
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

protocol SceneCoordinatorType {
    func transition(scene: Scene, typeTransition: TransitionType)
}
