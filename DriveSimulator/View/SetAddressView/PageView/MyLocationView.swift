//
//  MyLocationView.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/10.
//

import Foundation
import UIKit

class MyLocationView: XibView{
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var instructionButton: Button!
    
    lazy var labelText: String = ""{
        didSet{
            addressLabel.text = labelText
            //ボタンが押下可能かどうか決定
            let model = MyLocationModel()
            self.instructionButton.isEnabled = model.isButtonEnabled(text: labelText)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //ボタンのタイトルを設定
        let model = MyLocationModel()
        instructionButton.setTitle(model.setButtonTitle(action: PlaceAction.shared.action), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
