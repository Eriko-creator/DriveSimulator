//
//  HistoryEmptyView.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/13.
//

import Foundation
import UIKit

class HistoryEmptyTableView: XibView{
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var historyImageView: UIImageView!
    
    //AutoLayoutが使えないのでコードで設定
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(displayP3Red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        historyImageView.frame.size = CGSize(width: 100, height: 100)
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.center = self.center
        stackView.addArrangedSubview(historyImageView)
        stackView.addArrangedSubview(instructionLabel)
        
    }
}
