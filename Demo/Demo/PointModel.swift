//
//  PointModel.swift
//  Demo
//
//  Created by tsaievan on 23/2/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit


/// 点模型
class PointModel: NSObject {
    @objc var count = 0
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
