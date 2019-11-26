//
//  ForgetPasswordController.swift
//  惠豆商城
//
//  Created by 张昊 on 2019/11/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class ForgetPasswordController: ZXDBaseViewController,UITextFieldDelegate {
    
    
    lazy var submissionButton:UIButton = {
        let submissionButton = UIButton(frame: AutoFrame(x: 25, y: 345, width: 325, height: 45))
        submissionButton.backgroundColor = UIColor.init(rgb: 0xE60121)
        submissionButton.layer.cornerRadius = 22.5*ScalePpth
        submissionButton.layer.masksToBounds = true
        submissionButton.titleLabel?.font = FontSize(height: 17)
        submissionButton.setTitleColor(.white, for: .normal)
        submissionButton.setTitle("提交", for: .normal)
        return submissionButton
    }()
    
    lazy var getverificationButton:UIButton = {
        let getverificationButton = UIButton(frame: AutoFrame(x: 260, y: 115, width: 95, height: 45))
        getverificationButton.titleLabel?.font = FontSize(height: 13)
        getverificationButton.setTitleColor(.init(rgb: 0xE70422), for: .normal)
        getverificationButton.setTitle("获取验证码", for: .normal)
        return getverificationButton
    }()
    
    lazy var textFieldArray:NSMutableArray = {
        let textFieldArray = NSMutableArray.init()
        return textFieldArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "忘记密码"
        textFieldArray.add(textfieldFunc(name: "请输入手机号码", space: 50, imageName: "register_phone"))
        textFieldArray.add(textfieldFunc(name: "请输入验证码", space: 115, imageName: "register_verification"))
        textFieldArray.add(textfieldFunc(name: "请输入密码", space: 180, imageName: "register_password"))
        textFieldArray.add(textfieldFunc(name: "请再次输入密码", space: 245, imageName: "register_password"))
        view.addSubview(submissionButton)
        view.addSubview(getverificationButton)
    }
    
    func textfieldFunc(name:String,space:CGFloat,imageName:String) ->UITextField {
        let textfield = UITextField(frame: AutoFrame(x: 25, y: space, width: 325, height: 45))
        textfield.placeholder = name
        textfield.delegate = self
        textfield.clearButtonMode = UITextField.ViewMode.always
        textfield.borderStyle = .none
        textfield.backgroundColor = .init(rgb: 0xF5F5F5)
        textfield.layer.cornerRadius = 22.5*ScalePpth
        textfield.layer.masksToBounds = true
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.keyboardType = UIKeyboardType.numberPad
        
        let leftView = UIView(frame: AutoFrame(x: 0, y: 0, width: 57, height: 45))
        let imageView = UIImageView(frame: AutoFrame(x: 27, y: 13, width: 13, height: 18))
        imageView.image = UIImage(named: imageName)
        imageView.sizeToFit()
        leftView.addSubview(imageView)
        textfield.leftView = leftView
        view.addSubview(textfield)
        return textfield
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldArray.enumerateObjects { (textField, i, result) in
            let tf:UITextField = textField as! UITextField
            tf.endEditing(true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
