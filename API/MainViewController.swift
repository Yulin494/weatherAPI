//
//  MainViewController.swift
//  API
//
//  Created by imac-1681 on 2024/9/11.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARk: - IBOutlet
    @IBOutlet var AreaPickerView: UIPickerView!
    @IBOutlet var confirmBTN: UIButton!
    
    // MARK: - Proprtty
    let Area: [String] = [
        "宜蘭縣",
        "花蓮縣",
        "臺東縣",
        "澎湖縣",
        "金門縣",
        "連江縣",
        "臺北市",
        "新北市",
        "桃園市",
        "臺中市",
        "臺南市",
        "高雄市",
        "新竹縣",
        "新竹市",
        "苗栗縣",
        "彰化縣",
        "南投縣",
        "嘉義縣",
        "嘉義市",
        "屏東縣"
    ]
    var selectArea: String?
    //傳值步驟2 設定委任
    //var delegate: AreaSelectDelegate?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AreaPickerView.delegate = self
        AreaPickerView.dataSource = self
        //一進去頁面就可以選擇，不必跳出再跳回
        AreaPickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView(AreaPickerView, didSelectRow: 0, inComponent: 0)
    }
    // MARK: - UI Setting
    
    // MARK: - IBAction
    @IBAction func Confirm(_ sender: Any) {
        if let selectAreaa = selectArea {
            print("這是所選擇的地區 \(selectArea ?? "no")")
            let areaVC = AreaViewController()
            areaVC.selectedArea = selectAreaa
            self.present(areaVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Function
    
}
// MARK: - Extensions
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Area.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Area[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectArea = Area[row]
    }
}
//傳值步驟1 宣告protocol func
//protocol AreaSelectDelegate: AnyObject {
//    func didSendSelectArea(_ Area: String)
//}
