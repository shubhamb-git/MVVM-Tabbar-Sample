//
//  ViewController.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    ///Cal tabbar
    override func viewDidAppear(_ animated: Bool) {
        let vc = TabBarController.init(nibName: TabBarController.stringRepresentation, bundle: nil)
        UIApplication.shared.delegate?.window!!.rootViewController = vc
    }

}

