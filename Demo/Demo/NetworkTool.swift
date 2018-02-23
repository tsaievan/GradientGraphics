//
//  NetworkTool.swift
//  Demo
//
//  Created by tsaievan on 23/2/18.
//  Copyright © 2018年 tsaievan. All rights reserved.
//

import UIKit


/// 一个简单的网络下载工具
class NetworkTool {
    class func getData(url: String? = DEFAULT_URL, success: ((_ response: [PointModel]) -> Void)?, failue: ((_ error: Error) -> Void)?) {
        DispatchQueue.global().async {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            guard let urlString = url else {
                return
            }
            let urlReq = URLRequest(url: URL(string: urlString)!)
            session.dataTask(with: urlReq, completionHandler: { (data, _, error) in
                if let data = data {
                    guard let result = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) else {
                        return
                    }
                    let pointArray = (result as! NSDictionary).object(forKey: "data")
                    var mtArray = [PointModel]()
                    for pointDict in pointArray as! Array<Any> {
                        let pointModel = PointModel(dict: pointDict as! [String : Any])
                        mtArray.append(pointModel)
                    }
                    DispatchQueue.main.async {
                        guard let successClosure = success else {
                            return
                        }
                        successClosure(mtArray)
                    }
                }
                if let error = error {
                    DispatchQueue.main.async {
                        guard let failueClosure = failue else {
                            return
                        }
                        failueClosure(error)
                    }
                }
            }).resume()
        }
    }
}
