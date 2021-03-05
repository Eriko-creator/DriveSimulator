//
//  SettingButton.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/03/04.
//

import Foundation
import UIKit

@IBDesignable class SettingButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }
    
    private func customDesign(){
        
        setImage(UIImage(named: "settingButton"), for: .normal)
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        frame.size = CGSize(width: 40, height: 40)
    }
}

