//
//  RechargeController.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/8.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class RechargeController: ZXDBaseViewController,UITextFieldDelegate {
    
    lazy var rightButton:UIButton = {
        let rightBtn = UIButton(frame: AutoFrame(x: 0, y: 0, width: 60, height: 15))
        rightBtn.setTitle("充值记录", for: .normal)
        rightBtn.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize:13*ScalePpth)
        rightBtn.addTarget(self, action: #selector(rightBtnAction(button:)),for: UIControl.Event.touchUpInside)
        return rightBtn
    }()
    
    lazy var rechargeButton:UIButton = {
        let rechargeButton = UIButton(frame: AutoFrame(x: 37.5, y: 225, width: 300, height: 45))
        rechargeButton.setTitle("立即充值", for: .normal)
        rechargeButton.setTitleColor(UIColor(rgb: 0xffffff), for: .normal)
        rechargeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize:17*ScalePpth)
        rechargeButton.layer.cornerRadius = 22.5*ScalePpth;
        rechargeButton.layer.masksToBounds = true
        rechargeButton.backgroundColor = UIColor(rgb: 0xE60121)
        return rechargeButton
    }()
    
    lazy var textField:UITextField = {
        let textField = UITextField(frame: AutoFrame(x: 15, y: 146, width: 200, height: 16))
        textField.textColor = UIColor(rgb: 0xBFBFBF)
        textField.placeholder = "请输入充值金额"
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.numberPad
        textField.borderStyle = UITextField.BorderStyle.none
        textField.font = UIFont.systemFont(ofSize:16*ScalePpth)
        return textField
    }()
    
    lazy var moneyLabel:UILabel = {
        let moneyLabel = UILabel(frame: AutoFrame(x: 15, y: 59, width: 200, height: 17))
        moneyLabel.text = "￥200.00"
        moneyLabel.textColor = UIColor(rgb: 0xE70422)
        moneyLabel.font = UIFont.systemFont(ofSize:17*ScalePpth)
        return moneyLabel
    }()
    
    lazy var grayView:UIView  = {
       let grayView = UIView(frame: AutoFrame(x: 0, y: 0, width: 375, height:5))
        grayView.backgroundColor = UIColor(rgb: 0xf0f0f0)
        return grayView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "充值"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)
        setUI()
    }
    
    func setUI () {
        view.addSubview(grayView)
        let array = ["金额","充值"]
        for i in 0..<2 {
            let label = UILabel(frame: AutoFrame(x: 15, y:  CGFloat(30+CGFloat(i)*85.5), width: 100, height: 17))
            label.textColor = UIColor.init(rgb: 0x261900)
            label.text = array[i]
            label.font = .systemFont(ofSize: 17*ScalePpth)
            view.addSubview(label)
            let line = UIView(frame: AutoFrame(x: 15, y: CGFloat(82+CGFloat(i)*85.5), width: 360, height: 0.5))
            line.backgroundColor = UIColor.init(rgb: 0xF0F0F0)
            view.addSubview(line)
        }
        view.addSubview(moneyLabel)
        view.addSubview(textField)
        view.addSubview(rechargeButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
  @objc  func rightBtnAction(button:UIButton) {
        navigationController?.pushViewController(RechargeRecordController.init(), animated: true)
    }
}
