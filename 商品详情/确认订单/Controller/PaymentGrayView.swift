//
//  PaymentGrayView.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/7.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class PaymentGrayView: UIView {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        var lastButton:UIButton!
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.backgroundColor = UIColor(rgbs: 0x000000, alpha: 0.6)
        setUpUI()
    }
    
    func setUpUI () {
        var modeLabel:UILabel!
        var whiteView:UIView!
        var topLabel:UILabel!
        var selectButton:UIButton!
        var sureButton:UIButton!
        
        
        let titleArray = ["现金支付","金豆支付","现金+金豆支付","微信支付","支付宝"]
        let payArray = ["xianjin","jindou","zonghe","weixin","zhifubao"]
        
        whiteView = UIView(frame:AutoFrame(x: 54, y: 179, width: 267, height: 334))
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.cornerRadius = 10*ScalePpth
        whiteView.layer.masksToBounds = true
        addSubview(whiteView)
        
        modeLabel = UILabel(frame: CGRect(x: 0, y: 54.5, width:267*ScalePpth, height: 0.5))
        modeLabel.backgroundColor = UIColor(rgb: 0xEEEEEE)
        whiteView.addSubview(modeLabel)
        
        topLabel = UILabel(frame: AutoFrame(x: 0, y: 19, width: 267, height: 15))
        topLabel.textColor = UIColor.black
        topLabel.text = "支付方式"
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.systemFont(ofSize: 15)
        whiteView.addSubview(topLabel)
        
        for i in 0..<5 {
            
            var imageView:UIImageView!
            var typeLabel:UILabel!
            
            imageView = UIImageView(frame: AutoFrame(x: 18.5, y:CGFloat(71+40*i), width: 20, height: 20))
            imageView.image = UIImage(named: payArray[i])
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 10*ScalePpth
            whiteView.addSubview(imageView)
            
            typeLabel = UILabel(frame: AutoFrame(x: 49, y: CGFloat(75+40*i), width: 120, height: 14))
            typeLabel.textColor = UIColor.black
            typeLabel.text = titleArray[i]
            typeLabel.font = UIFont.systemFont(ofSize: 14*ScalePpth)
            whiteView.addSubview(typeLabel)
            
            selectButton = UIButton(frame: AutoFrame(x: 213, y: CGFloat(54+40*i), width: 54, height: 54))
           
            if i>0 {
                 selectButton.setImage(UIImage(named: "tan_nocheck"), for: .normal)
            } else {
                 selectButton.setImage(UIImage(named: "tan_check"), for: .normal)
                 lastButton = selectButton
            }
            selectButton.addTarget(self, action: #selector(selectButtonAction(button:)), for: UIControl.Event.touchUpInside)
            whiteView.addSubview(selectButton)
        }
        
        sureButton = UIButton(frame: AutoFrame(x: 43.5, y: 276, width: 180, height: 38))
        sureButton.backgroundColor = UIColor(rgb: 0xFF5044)
        sureButton.layer.cornerRadius = 19*ScalePpth
        sureButton.layer.masksToBounds = true
        sureButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15*ScalePpth)
        sureButton.setTitle("确认支付", for: .normal)
        sureButton.setTitleColor(.white, for: .normal)
        sureButton.addTarget(self, action:#selector(sureButtonAction(button:)) , for: UIControl.Event.touchUpInside)
        whiteView.addSubview(sureButton)
    }
    
   @objc  func sureButtonAction(button:UIButton) {
        self.removeFromSuperview()
    }
    
    @objc  func selectButtonAction(button:UIButton) {
         lastButton.setImage(UIImage(named: "tan_nocheck"), for: .normal)
         button.setImage(UIImage(named: "tan_check"), for: .normal)
         lastButton = button;
    }
}
