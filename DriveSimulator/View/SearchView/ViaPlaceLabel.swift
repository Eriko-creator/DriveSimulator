//
//  ViaPlaceLabel.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/17.
//

import Foundation
import UIKit

class ViaPlaceLabel: XibView{
    
    @IBOutlet weak var viaPlaceNameButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cancelButton.addTarget(self, action: #selector(deleteView), for: .touchUpInside)
    }
    
    @objc func deleteView(){
        removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
