//
//  SetAddressViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/26.
//


import UIKit

protocol SetAddressViewControllerDelegate {
    func startAutoComplete(text:String)
}

class SetAddressViewController: UIViewController{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    weak var currentViewController: UIViewController?
    
    var delegate: SetAddressViewControllerDelegate?
    
    var tag:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(tag)
        //最初に表示するviewを設定
        self.currentViewController = self.storyboard!.instantiateViewController(withIdentifier: "selectAddressVC")
        self.addChild(self.currentViewController!)
        self.addSubview(subView: currentViewController!.view, toView: self.containerView)
        
        //searchBarのデリゲートを設定
        searchBar.delegate = self
        
    }
    
    private func addSubview(subView:UIView, toView parentView: UIView) {
        parentView.addSubview(subView)
        //subViewをparentViewに合わせる
        subView.frame = parentView.bounds
        subView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

extension SetAddressViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchBarがタップされた時にviewControllerを切り替える
        let autoCompleteViewController = self.storyboard?.instantiateViewController(identifier: "autoCompleteVC")
        cycleFromViewController(oldViewController: self.currentViewController!, toViewController: autoCompleteViewController!)
        self.currentViewController = autoCompleteViewController
        //デリゲートを設定
        self.delegate = autoCompleteViewController as? SetAddressViewControllerDelegate
        
        //Cancelボタンを表示
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //AutoCompleteの結果を表示する
        self.delegate?.startAutoComplete(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //Cancelボタンがタップされた時に元のViewControllerに戻る
        let selectAddressViewController = self.storyboard?.instantiateViewController(identifier: "selectAddressVC")
        cycleFromViewController(oldViewController: self.currentViewController!, toViewController: selectAddressViewController!)
        self.currentViewController = selectAddressViewController
        
        //Cancelボタンを非表示にする、キーボードをしまう
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.endEditing(true)
        resignFirstResponder()
    }
    
    private func cycleFromViewController(oldViewController:UIViewController, toViewController newViewController:UIViewController){
        
        oldViewController.willMove(toParent: newViewController)
        self.addChild(newViewController)
        self.addSubview(subView: newViewController.view, toView: self.containerView!)
        
        oldViewController.view.removeFromSuperview()
        oldViewController.removeFromParent()
        newViewController.didMove(toParent: self)
    }
    
}
