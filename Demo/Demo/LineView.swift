//
//  LineView.swift
//  Demo
//
//  Created by tsaievan on 23/2/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit

/// 画线的视图
class LineView: UIView {
    var dataArray: [PointModel]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BACKGROUND_COLOR
        drawLineBox()
        NetworkTool.getData(success: { (pointArray) in
            self.dataArray = pointArray
            self.setNeedsDisplay()
        }, failue: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCurveLine()
    }
}

extension LineView {
    
    /// 画线框的背景
    fileprivate func drawLineBox() {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(LINE_WIDTH)
        context?.setStrokeColor(UIColor.darkGray.cgColor)
        context?.addRect(CGRect(x: FLOAT_ZERO, y: FLOAT_ZERO, width: self.bounds.width, height: self.bounds.height))
        context?.strokePath()
    }
    
    
    /// 画曲线
    fileprivate func drawCurveLine() {
        
        ///< 1. 获取图形上下文
        let context = UIGraphicsGetCurrentContext()
        var px: CGFloat = FLOAT_ZERO
        var py: CGFloat = frame.size.height
        
        ///< 2. 创建路径对象
        let path = CGMutablePath()
        
        ///< 3. 将路径移动到起始点
        path.move(to: CGPoint(x: px, y: py))
        guard let dataArray = dataArray else {
            return
        }
        let width = self.bounds.width / CGFloat(dataArray.count)
        
        ///< 4. 遍历点模型, 将点都连接起来, 形成完整的路径
        var maxPy: CGFloat = CGFloat(MAXFLOAT)
        for point in dataArray.enumerated() {
            px = CGFloat(point.offset) * width
            py = frame.size.height - CGFloat(point.element.count)
            if maxPy > py {
                maxPy = py
            }
            path.addLine(to: CGPoint(x: px, y: py))
        }
        
        ///< 5. 将线连接到终点
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
        
        ///< 6. 上下文添加路径
        context?.addPath(path)
        
        ///< 7. 做一些设置
            ///< 7.1 设置线的颜色
        context?.setStrokeColor(LINE_COLOR.cgColor)
            ///< 7.2 设置线头的样式
        context?.setLineCap(.square)
            ///< 7.3 设置线宽
        context?.setLineWidth(LINE_WIDTH)
        
        ///< 8. 开始画线
        context?.strokePath()
    
        ///< 9. 将画好的线添加到上下文中, 继续画
        context?.addPath(path)
        
        ///< 10. 将线移动到起始点, 这样就形成了一个封闭的环境
        context?.addLine(to: CGPoint(x: FLOAT_ZERO, y: frame.size.height))
        
        ///< 11. 保存当前的图形上下文状态
        context?.saveGState()
        
        ///< 12. 剪切
        context?.clip()
        
        ///< 11. 获取渐变的起始颜色和终止颜色
        let startColor = START_COLOR ///< 深蓝
        let endColor = END_COLOR ///< 浅蓝
        
        ///< 12. 获取颜色的组成
        guard let startComp =  startColor.cgColor.components,
            let endComp = endColor.cgColor.components else {
                return
        }
    
        ///< 13. 将颜色的组成重新组合, 并设置一些基本参数
        let components = [startComp[0],
                          startComp[1],
                          startComp[2],
                          startComp[3],
                          endComp[0],
                          endComp[1],
                          endComp[2],
                          endComp[3]]
        
        let locations: [CGFloat] = [FLOAT_ZERO, FLOAT_ONE]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        ///< 14. 将上面的参数传进去生成梯度
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: GRADIENT_COUNT) else {
            return
        }
        
        ///< 15 设置渐变的起始点和终点
        let startPoint = CGPoint(x: FLOAT_ZERO, y: maxPy)
        let endPoint = CGPoint(x: FLOAT_ZERO, y: frame.size.height)
        
        ///< 16. 开始画渐变
        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
        
        ///< 17. 恢复上下文状态
        context?.restoreGState()
    }
}
