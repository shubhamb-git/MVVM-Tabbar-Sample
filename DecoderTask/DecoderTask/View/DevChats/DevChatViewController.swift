//
//  DevChatViewController.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class DevChatViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
