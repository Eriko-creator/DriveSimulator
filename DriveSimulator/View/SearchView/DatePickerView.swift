//
//  DatePickerView.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/18.
//

import Foundation
import UIKit

class DatePickerView: XibView{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func cancelButton(_ sender: Any) {
        removeFromSuperview()
    }
    
    @IBAction func currentTimeButton(_ sender: Any) {
        //現在時刻を表示する
        datePicker.setDate(Date(), animated: true)
        
    }
    
    @IBAction func doneButton(_ sender: Any) {
        //SearchVCに日付を渡す
        let dateFormatter = DateFormatter()
        let date = dateFormatter.dateFormatForLabel(date: datePicker.date)
        print(date)
        NotificationCenter.default.post(name: .selectedDate, object: nil, userInfo: ["selectedDate": date])
        //クエリに日付を追加
        let searchQueryMaker = SearchQueryMaker.shared
        searchQueryMaker.date = dateFormatter.dateFormatForQuery(date: datePicker.date)
        removeFromSuperview()
    }
}

extension Notification.Name{
    static let selectedDate = Notification.Name("selectedDate")
}
