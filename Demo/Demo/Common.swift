//
//  Common.swift
//  Demo
//
//  Created by tsaievan on 23/2/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

let X = 10

let Y = 30

let SCREEN_BOUNDS = UIScreen.main.bounds

let BOX_WIDTH = UIScreen.main.bounds.width - 20

let BOX_HEIGHT = 330

let BOX_RECT = CGRect(x: X, y: Y, width: Int(BOX_WIDTH), height: BOX_HEIGHT)

let LINE_WIDTH: CGFloat = 0.5

let FLOAT_ZERO: CGFloat = 0.0

let FLOAT_ONE: CGFloat = 1.0

let START_COLOR = UIColor(displayP3Red: FLOAT_ZERO, green: FLOAT_ZERO, blue: 0.1, alpha: 0.9)

let END_COLOR = UIColor(displayP3Red: FLOAT_ZERO, green: FLOAT_ZERO, blue: 1.0, alpha: 0.2)

let BACKGROUND_COLOR = UIColor(white: 0.9, alpha: 1)

let LINE_COLOR = UIColor.blue

let GRADIENT_COUNT = 2

let DEFAULT_URL = "https://api.huobi.pro/market/history/kline"

