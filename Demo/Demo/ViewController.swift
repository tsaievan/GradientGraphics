//
//  ViewController.swift
//  Demo
//
//  Created by tsaievan on 23/2/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let lineView = LineView(frame: BOX_RECT)
        view.addSubview(lineView)
    }
}

