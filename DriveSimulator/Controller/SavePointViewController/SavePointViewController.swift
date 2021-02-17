//
//  SavePointViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/10.
//

import UIKit

class SavePointViewController: UIViewController {
    
    private let model = SavePointModel()
    private let myView = SavePointView()
    private let placeAction = PlaceAction.shared
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSavePointVC()
        //キーボードが表示された時Viewの位置を上げる
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードが隠れた時元の位置に戻す
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        let textFieldHeight = myView.placeNameTextField.frame.height
        let buttonHeight = myView.savePointButton.frame.height
        self.view.frame.origin.y = -textFieldHeight-buttonHeight
        myView.savePointButton.isEnabled = false
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        self.view.frame.origin.y = 0
        myView.savePointButton.isEnabled = true
    }
    
    //画面のどこかをタッチしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myView.placeNameTextField.resignFirstResponder()
    }
    
    private func setUpSavePointVC(){
        //addressLabelに地点の住所を表示する
        model.setAddress()
        myView.addressLabel.text = placeAction.place.address
        //TextFieldに地点名をセットしておく（ある場合）
        myView.placeNameTextField.text = placeAction.place.placeName
        
        myView.savePointButton.isEnabled = true
        myView.savePointButton.addTarget(self, action: #selector(savePoint), for: .touchUpInside)
        myView.placeNameTextField.delegate = self
    }
    
    //保存できた・できないに対応してラベルを表示するメソッド
    @objc func savePoint(){
        do{
            try model.checkPoint(placeName: myView.placeNameTextField.text ?? "", lat: placeAction.place.lat, lng: placeAction.place.lng)
            print("保存可能です。")
            
        }catch SavePointModel.InvalidData.voidPlaceName{
            showAlertLabel(inValidData: .voidPlaceName)
            print("voidPlaceName")
        }catch SavePointModel.InvalidData.invalidPlaceName{
            showAlertLabel(inValidData: .invalidPlaceName)
            print("invalidPlaceName")
        }catch SavePointModel.InvalidData.duplicatedPlaceName{
            showAlertLabel(inValidData: .duplicatedPlaceName)
            print("duplicatedPlaceName")
        }catch SavePointModel.InvalidData.duplicatedLocation{
            showAlertLabel(inValidData: .duplicatedLocation)
            print("duplicatedLocation")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    private func showAlertLabel(inValidData: SavePointModel.InvalidData){
        
        //ラベルを作成
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let navigationBarY = self.navigationController?.navigationBar.frame.maxY ?? 0
        let label = AlertLabel(frame: CGRect(x: 0, y: navigationBarY-navigationBarHeight, width: view.bounds.width, height: 50))
        label.text = inValidData.alertText
        myView.addSubview(label)
        //アニメーションさせる
        UILabel.animate(withDuration: 1.0) {
            label.frame.origin.y += navigationBarHeight
        }completion: { (flag) in
            UILabel.animate(withDuration: 1.0, delay: 3.0, options: .curveLinear) {
                label.frame.origin.y -= navigationBarHeight
            } completion: { (flag) in
                label.isHidden = true
            }
        }
    }
}
extension SavePointViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
