//
//  InviteFriendsController.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class InviteFriendsController: ZXDBaseViewController {
 
    // lazy的作用是只会赋值一次
    lazy var whiteView : UIView = {
        let whiteView = UIView(frame: AutoFrame(x: 30, y: 36, width: 315, height: 402))
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 5*ScalePpth
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: AutoFrame(x: 87.5, y: 140, width: 140, height: 140))
        imageView.image = UIImage(named: "QRCode.png")
        return imageView
    }()
    
    lazy var button : UIButton = {
        let button = UIButton(frame: AutoFrame(x: 17, y: 343, width: 281, height: 44))
        button.backgroundColor = UIColor(rgb: 0xE60121)
        button.setTitle("转发邀请", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22*ScalePpth
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "邀请好友"
        titleLabel.textColor = .white
        backButton.setImage(UIImage(named: "de_lefttop"), for: .normal)
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xFF6D38)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI () {
        let TColor = UIColor(rgb: 0xFF6D38)
        //蓝色
        let BColor = UIColor(rgb: 0xFF4425)
        //将颜色和颜色的位置定义在数组内
        let gradientColors: [CGColor] = [TColor.cgColor, BColor.cgColor]
        //创建并实例化CAGradientLayer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        //渲染的起始位置
        gradientLayer.startPoint = CGPoint(x:0,y: 0)
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint(x:0,y: 1)
        //设置frame和插入view的layer
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(whiteView)
        addWhiteSubViews()
    }
    
    func addWhiteSubViews () {
        let topLabel = UILabel(frame: AutoFrame(x: 0, y: 27, width: 315, height: 16))
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.systemFont(ofSize: 16*ScalePpth)
        topLabel.textColor = UIColor(rgb: 0x333333)
        topLabel.text = "您的邀请码"
        whiteView.addSubview(topLabel)
        
        let array = ["2","0","3","0","0","1"]
        for i in 0..<6 {
            let backGroundView = UIView(frame: AutoFrame(x: (CGFloat(82+i*26)), y: 57, width: 21, height: 30))
            backGroundView.backgroundColor =  .init(rgb: 0xEFEFEF)
            backGroundView.layer.masksToBounds = true
            backGroundView.layer.cornerRadius = 2*ScalePpth
            whiteView.addSubview(backGroundView)
            
            let label = UILabel(frame: AutoFrame(x: (CGFloat(82+i*26)), y: 57, width: 21, height: 30))
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 15*ScalePpth)
            label.text = array[i]
            label.textColor = .init(rgb: 0x333333)
            whiteView.addSubview(label)
        }
        
        let centerLabel = UILabel(frame: AutoFrame(x: 0, y: 101, width: 315, height: 12))
        centerLabel.textAlignment = NSTextAlignment.center
        centerLabel.font = UIFont.systemFont(ofSize: 12*ScalePpth)
        centerLabel.textColor = UIColor(rgb: 0x999999)
        centerLabel.text = "邀请的好友也可在注册时直接填写邀请码"
        whiteView.addSubview(centerLabel)
        whiteView.addSubview(imageView)
        
        let bottomLabel = UILabel(frame: AutoFrame(x: 0, y: 296, width: 315, height: 13))
        bottomLabel.textAlignment = NSTextAlignment.center
        bottomLabel.font = UIFont.systemFont(ofSize: 13*ScalePpth)
        bottomLabel.textColor = UIColor(rgb: 0x999999)
        bottomLabel.text = "长按图片即可保存"
        whiteView.addSubview(bottomLabel)
        whiteView.addSubview(button)
        
        let titleArray = ["1","2"];
        let textArray = ["长按图片下载二维码，朋友扫码加入","点击按钮邀请朋友进入界面，输入邀请码"];
        for i in 0..<2 {
            let leftLabel = UILabel(frame: AutoFrame(x: 30, y: (CGFloat(522-64+i*26)), width: 18, height: 18))
            leftLabel.textAlignment = NSTextAlignment.center
            leftLabel.font = UIFont.systemFont(ofSize: 11*ScalePpth)
            leftLabel.textColor = UIColor(rgb: 0xffffff)
            leftLabel.text = titleArray[i]
            leftLabel.backgroundColor = UIColor(rgbs: 0xffffff, alpha: 0.2)
            leftLabel.layer.masksToBounds = true
            leftLabel.layer.cornerRadius = 9*ScalePpth
            view.addSubview(leftLabel)
            
            let rightLabel = UILabel(frame: AutoFrame(x: 54, y:(CGFloat(526-64+i*26)), width: 290, height: 11))
            rightLabel.font = UIFont.systemFont(ofSize: 11*ScalePpth)
            rightLabel.textColor = UIColor(rgb: 0xffffff)
            rightLabel.text = textArray[i]
            view.addSubview(rightLabel)
        }
        
        
    }
}
