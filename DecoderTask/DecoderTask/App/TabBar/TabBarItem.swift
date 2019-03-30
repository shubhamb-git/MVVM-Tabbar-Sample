//
//  TabBarItem.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation   
import UIKit

struct TabBarItemController {
    
    let controller: UIViewController
    let imageEnbled: String
    let imageDisabled: String
    private let controllerName: String
    
    
    init(itemType: TabBarItems) {
        let storyBoard: UIStoryboard = UIStoryboard(name: itemType.rawValue, bundle: nil)
        switch itemType {
        case .DevChats:
            self.controllerName = AppConstants.TabBarItems.DevChats.name
            self.controller = storyBoard.instantiateViewController(withIdentifier: controllerName) as! DevChatViewController
            self.imageEnbled = AppConstants.TabBarItems.DevChats.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.DevChats.imageDisabled
        case .Thread:
            self.controllerName = AppConstants.TabBarItems.Thread.name
            self.controller = storyBoard.instantiateViewController(withIdentifier: controllerName) as! ThreadViewController
            self.imageEnbled = AppConstants.TabBarItems.Thread.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.Thread.imageDisabled
        case .QnA:
            self.controllerName = AppConstants.TabBarItems.QnA.name
            self.controller = storyBoard.instantiateViewController(withIdentifier: controllerName) as! QAViewController
            self.imageEnbled = AppConstants.TabBarItems.QnA.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.QnA.imageDisabled
        case .Code:
            self.controllerName = AppConstants.TabBarItems.Code.name
            self.controller = storyBoard.instantiateViewController(withIdentifier: controllerName) as! CodeViewController
            self.imageEnbled = AppConstants.TabBarItems.Code.imageEnbled
            self.imageDisabled = AppConstants.TabBarItems.Code.imageDisabled
        }
    }
}

