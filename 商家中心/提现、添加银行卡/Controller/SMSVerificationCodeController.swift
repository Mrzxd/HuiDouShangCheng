//
//  SMSVerificationCodeController.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/20.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class SMSVerificationCodeController: ZXDBaseViewController,UITextFieldDelegate {

    lazy var topView:UIView = {
                 let topView = UIView(frame: AutoFrame(x: 0, y: 0, width: 375, height: 5))
                  topView.backgroundColor = .init(rgb: 0xf0f0f0)
                  return topView
    }()
           
    lazy var remindLabel:UILabel = {
        let label = UILabel(frame: AutoFrame(x: 15, y: 25, width: 300, height: 12))
        label.textColor = .init(rgb: 0x999999)
        label.font = FontSize(height: 12)
        label.text = "请输入手机139****3456收到的短信验证码"
        return label
    }()
    
   lazy var firstLabel:UILabel = {
          let label = UILabel(frame: AutoFrame(x: 15, y: 70, width: 100, height: 17))
          label.textColor = .init(rgb: 0x261900)
          label.font = FontSize(height: 17)
          label.text = "验证码"
          return label
      }()
    
    lazy var redButton:UIButton = {
               let button = UIButton(frame: AutoFrame(x: 37.5, y: 162, width: 300, height: 45))
               button.backgroundColor = .init(rgb: 0xE60121)
               button.titleLabel?.font = FontSize(height: 17)
               button.setTitleColor(.white, for: .normal)
               button.setTitle("验证信息", for: .normal)
               button.layer.cornerRadius = 22.5*ScalePpth
               button.layer.masksToBounds = true
               button.addTarget(self, action: #selector(verifyInformation(button:)), for: .touchUpInside)
               return button
        }()
    
    lazy var remindButton:UIButton = {
        let button = UIButton(frame: AutoFrame(x: 276, y: 107.5, width: 90, height: 32))
           button.titleLabel?.font = FontSize(height: 12)
           button.setTitleColor(.init(rgb: 0x999999), for: .normal)
           button.setTitle("收不到验证码？", for: .normal)
           button.addTarget(self, action: #selector(notGet(button:)), for: .touchUpInside)
           return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "手机短信验证码"
        let line = UIView(frame: AutoFrame(x: 0, y: 110, width: 375, height: 0.5))
                line.backgroundColor = .init(rgb: 0xF0F0F0)
                view.addSubview(line)
        view.addSubview(topView)
        view.addSubview(remindLabel)
        view.addSubview(firstLabel)
        view.addSubview(textFieldInitial())
        view.addSubview(redButton)
        view.addSubview(remindButton)
    }
    
    func textFieldInitial() -> UITextField {
    let textField:UITextField = UITextField(frame: AutoFrame(x: 90, y: 60, width: 250, height: 36))
               textField.delegate = self
               textField.placeholder = "短信验证码"
               textField.textColor = .init(rgb: 0x261900)
               textField.borderStyle = .none
               textField.keyboardType = UIKeyboardType.numberPad
               textField.font = FontSize(height: 16)
               return textField
    }
    @objc func verifyInformation(button:UIButton) {
        
    }
    @objc func notGet(button:UIButton) {
           
       }
}
