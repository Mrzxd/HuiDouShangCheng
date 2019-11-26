//
//  Swift_M_H.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/7.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width
let ScalePpth = (CGFloat)(kScreenWidth/375.0)

public func AutoFrame(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat) -> CGRect {
    return CGRect(x: x*ScalePpth, y: y*ScalePpth, width: width*ScalePpth, height: height*ScalePpth)
}

public func FontSize(height:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: height*ScalePpth)
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
}
    
public convenience init(rgbs: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgbs & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbs & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbs & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}





