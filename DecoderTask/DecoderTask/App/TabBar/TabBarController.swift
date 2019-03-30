//
//  TabBarController.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

enum TabBarItems: String {
    case DevChats
    case Thread
    case QnA
    case Code
}

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var arrayVc: [UIViewController]?
    var itemController: TabBarItemController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        arrayVc = []
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .DevChats))
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .Thread))
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .QnA))
        arrayVc?.append(setViewControllerForTabBarItem(itemType: .Code))
        viewControllers = arrayVc
        self.tabBar.tintColor = #colorLiteral(red: 0.2274276018, green: 0.2274659276, blue: 0.2274192572, alpha: 1)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

private extension TabBarController {
    
    func setViewControllerForTabBarItem(itemType: TabBarItems)-> UIViewController {
        itemController =  TabBarItemController(itemType: itemType)
        itemController.controller.tabBarItem = UITabBarItem(title: itemType.rawValue, image: UIImage(named: itemController.imageDisabled )!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:itemController.imageEnbled))
        let viewController = UINavigationController(rootViewController: itemController.controller)
        return viewController
    }
}

