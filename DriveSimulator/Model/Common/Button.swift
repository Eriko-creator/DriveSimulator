//
//  Button.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/04.
//

import Foundation
import UIKit

@IBDesignable class Button: UIButton{
    
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
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 17)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layer.cornerRadius = 15.0
        
    }
    
    override var isEnabled: Bool{
        didSet{
            if self.isEnabled{
                self.backgroundColor = UIColor(displayP3Red: 245/255, green: 178/255, blue: 78/255, alpha: 1.0)
            }else {
                self.backgroundColor = UIColor(displayP3Red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
            }
        }
    }
}
