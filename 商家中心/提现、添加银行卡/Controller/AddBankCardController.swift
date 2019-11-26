//
//  AddBankCardController.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/20.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class AddBankCardController: ZXDBaseViewController,UITextFieldDelegate {

    lazy var topView:UIView = {
          let topView = UIView(frame: AutoFrame(x: 0, y: 0, width: 375, height: 5))
           topView.backgroundColor = .init(rgb: 0xf0f0f0)
           return topView
       }()
    
    lazy var firstLabel:UILabel = {
           let label = UILabel(frame: AutoFrame(x: 15, y: 32.5, width: 100, height: 17))
           label.textColor = .init(rgb: 0x261900)
           label.font = FontSize(height: 17)
           label.text = "持卡人"
           return label
       }()
    
    lazy var secondLabel:UILabel = {
        let label = UILabel(frame: AutoFrame(x: 15, y: 103, width: 100, height: 17))
        label.textColor = .init(rgb: 0x261900)
        label.font = FontSize(height: 17)
        label.text = "卡号"
        return label
    }()
    
    lazy var thirdLabel:UILabel = {
        let label = UILabel(frame: AutoFrame(x: 15, y: 173.5, width: 100, height: 17))
        label.textColor = .init(rgb: 0x261900)
        label.font = FontSize(height: 17)
        label.text = "身份证号"
        return label
    }()
    
    lazy var redButton:UIButton = {
          let button = UIButton(frame: AutoFrame(x: 37.5, y: 266, width: 300, height: 45))
          button.backgroundColor = .init(rgb: 0xE60121)
          button.titleLabel?.font = FontSize(height: 17)
          button.setTitleColor(.white, for: .normal)
          button.setTitle("下一步", for: .normal)
          button.layer.cornerRadius = 22.5*ScalePpth
          button.layer.masksToBounds = true
          button.addTarget(self, action: #selector(nextStep(button:)), for: .touchUpInside)
          return button
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "添加银行卡"
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(topView)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdLabel)
        view.addSubview(redButton)
        
        for i in 0...2 {
            let line = UIView(frame: AutoFrame(x: 0, y: CGFloat(70.0+CGFloat(i)*70.5), width: 375, height: 0.5))
                  line.backgroundColor = .init(rgb: 0xF0F0F0)
                  view.addSubview(line)
              }
    }
    
    @objc func nextStep(button:UIButton) {
        navigationController?.pushViewController(VerifyBankCardInformationController.init(), animated: true)
    }

//    func textFieldInitial(name:String,space:CGFloat) -> UITextField {
//        let textField:UITextField = UITextField(frame: AutoFrame(x: 125, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
//    }
    
}
