//
//  IBDesignable.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/18.
//

import Foundation
import UIKit

@IBDesignable
class DesignableButton: UIButton{
}

extension UIView{
    
    @IBInspectable
    var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}
