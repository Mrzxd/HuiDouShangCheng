//
//  CashierController.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//  收银台

import UIKit

class CashierController: ZXDBaseViewController {
 
    lazy var whiteView : UIView = {
          let whiteView = UIView(frame: AutoFrame(x: 30, y: 36, width: 315, height: 402))
          whiteView.backgroundColor = .white
          whiteView.layer.cornerRadius = 5*ScalePpth
          whiteView.layer.masksToBounds = true
          return whiteView
      }()
    
    lazy var imageView:UIImageView = {
       let imageView = UIImageView(frame: AutoFrame(x: 70, y: 134, width: 176, height: 176))
        imageView.backgroundColor = .init(rgb: 0xf0f0f0)
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "收银台"
        titleLabel.textColor = .white
               backButton.setImage(UIImage(named: "de_lefttop"), for: .normal)
               navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xFF6D38)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
       
    }
 func setUpUI () {
    let Tcolor = UIColor(rgb: 0xFF6D38)
    let BColor = UIColor(rgb: 0xFF4425)
     //将颜色和颜色的位置定义在数组内
    let gradientColors:[CGColor] = [Tcolor.cgColor,BColor.cgColor]
    //创建并实例化CAGradientLayer
    let gradientLayer:CAGradientLayer = CAGradientLayer()
    gradientLayer.colors = gradientColors
    //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
    //渲染的起始位置
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    //渲染的终止位置
    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    gradientLayer.frame = view.bounds
    view.layer.insertSublayer(gradientLayer, at: 0)
    view.addSubview(whiteView)
    addWhiteSubViews()
    }
     func addWhiteSubViews () {
        
        let topLabel = UILabel(frame: AutoFrame(x: 0, y: 44.5, width: 315, height: 18))
        topLabel.textAlignment = .center
        topLabel.textColor = .init(rgb: 0x333333)
        topLabel.text = "门店名称"
        topLabel.font = FontSize(height: 18)
        whiteView.addSubview(topLabel)
        
        let middleLabel = UILabel(frame: AutoFrame(x: 0, y: 81, width: 315, height: 13))
        middleLabel.textAlignment = .center
        middleLabel.textColor = .init(rgb: 0x333333)
        middleLabel.text = "无需加好友，扫二维码向我付款"
        middleLabel.font = FontSize(height: 13)
        whiteView.addSubview(middleLabel)
        whiteView.addSubview(imageView)
        
        let bottomLabel = UILabel(frame: AutoFrame(x: 0, y: 355, width: 315, height: 13))
        bottomLabel.textAlignment = .center
        bottomLabel.textColor = .init(rgb: 0x999999)
        bottomLabel.text = "长按图片即可保存"
        bottomLabel.font = FontSize(height: 13)
        whiteView.addSubview(bottomLabel)
    }
}
