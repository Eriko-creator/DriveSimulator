//
//  AlertLabel.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/16.
//

import Foundation
import UIKit

class AlertLabel: UILabel{
    
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
        textColor = .white
        textAlignment = .center
        font = .boldSystemFont(ofSize: 17)
        backgroundColor = UIColor(displayP3Red: 235/255, green: 82/255, blue: 82/255, alpha: 1.0)
        numberOfLines = 2
        minimumScaleFactor = 0.5
    }
}
