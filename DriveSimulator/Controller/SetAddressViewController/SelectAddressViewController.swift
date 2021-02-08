//
//  SelectAddressViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/27.
//

import UIKit

class SelectAddressViewController: UIViewController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var myLocationButton: UIButton!
    @IBOutlet weak var favoritePlaceButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    private let placeAction = PlaceAction.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instructionLabelに表示するtextを設定
        instructionLabel.text = placeAction.action?.labelText
        
        //containerViewにpageViewを設定
        guard let pageView = self.storyboard?.instantiateViewController(withIdentifier: "pageView") else {return}
        containerView.addSubview(pageView.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func changePageView(_ sender: Any) {
        
    }
}
