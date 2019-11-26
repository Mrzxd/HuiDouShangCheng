//
//  CashWithDrawalController.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/19.
//  Copyright © 2019 张兴栋. All rights reserved.
//  提现

import UIKit

class CashWithDrawalController: ZXDBaseViewController,UITextFieldDelegate {
  
    lazy var topView:UIView = {
       let topView = UIView(frame: AutoFrame(x: 0, y: 0, width: 375, height: 5))
        topView.backgroundColor = .init(rgb: 0xf0f0f0)
        return topView
    }()
    
    lazy var oneLabel:UILabel = {
        let label = UILabel(frame: AutoFrame(x: 15, y: 32.5, width: 100, height: 17))
        label.textColor = .init(rgb: 0x261900)
        label.font = FontSize(height: 17)
        label.text = "提现至"
        return label
    }()
    
    lazy var signalLabel:UILabel = {
           let label = UILabel(frame: AutoFrame(x: 20, y: 152, width: 30, height: 19))
           label.textColor = .init(rgb: 0x261900)
           label.font = FontSize(height: 19)
           label.text = "¥"
           return label
       }()
    
    lazy var secondLabel:UILabel = {
        let label = UILabel(frame: AutoFrame(x: 15, y: 100, width: 100, height: 17))
        label.textColor = .init(rgb: 0x261900)
        label.font = FontSize(height: 17)
        label.text = "提现金额"
        return label
    }()
    
    lazy var cardButton:UIButton = {
            let button = UIButton(frame: AutoFrame(x: 75, y: 5, width: 300, height: 70))
        button.titleLabel?.font = FontSize(height: 14)
        button.setTitleColor(.init(rgb: 0x999999), for: .normal)
        button.setTitle("暂无银行卡", for: .normal)
        button.setImage(UIImage(named: "issue_arrows"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 270*ScalePpth, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 160*ScalePpth, bottom: 0, right: 0)
        return button
    }()
    
    lazy var textFeild:UITextField = {
        let textFeild = UITextField(frame: AutoFrame(x: 55, y: 153.5, width: 300, height: 16))
        textFeild.placeholder = "请输入充值金额"
        textFeild.font = FontSize(height: 16)
        textFeild.textColor = .init(rgb:0x261900)
        textFeild.delegate = self
        textFeild.textAlignment = .right
        return textFeild
    }()
    
    lazy var redButton:UIButton = {
        let button = UIButton(frame: AutoFrame(x: 37.5, y: 236, width: 300, height: 45))
        button.backgroundColor = .init(rgb: 0xE60121)
        button.titleLabel?.font = FontSize(height: 17)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("添加银行卡", for: .normal)
        button.layer.cornerRadius = 22.5*ScalePpth
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addBanCard(button:)), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提现"
        view.addSubview(topView)
        view.addSubview(oneLabel)
        view.addSubview(secondLabel)
        view.addSubview(signalLabel)
        view.addSubview(cardButton)
        view.addSubview(textFeild)
        view.addSubview(redButton)
        
        for i in 0...1 {
            let line = UIView(frame: AutoFrame(x: 0, y: CGFloat(75+i*110), width: 375, height: 0.5))
            line.backgroundColor = .init(rgb: 0xF0F0F0)
            view.addSubview(line)
        }
    }
    
  @objc func addBanCard(button:UIButton) {
    navigationController?.pushViewController(AddBankCardController.init(), animated: true)
    }
}
