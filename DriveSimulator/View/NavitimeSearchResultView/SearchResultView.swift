//
//  SearchResultView.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/19.
//

import Foundation
import UIKit

class SearchResultView: UIScrollView{
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startPlaceLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var roadNameLabel: UILabel!
    @IBOutlet weak var goalPlaceLabel: UILabel!
    @IBOutlet weak var goalTimeLabel: UILabel!
    @IBOutlet weak var routeStackView: UIStackView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
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
