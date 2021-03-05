//
//  XibView.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/26.
//

import Foundation
import UIKit

class XibView: UIView{
    
    //StoryBoardから呼び出す際に使用される
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    //コードから呼び出す際に使用される
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNib()
    }
    
    func loadNib(){
        
        let bundle = Bundle(for: type(of: self))
        let nib = String(describing: type(of: self))
        let view = bundle.loadNibNamed(nib, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
    }
}
