//
//  AreaViewController.swift
//  API
//
//  Created by imac-1681 on 2024/9/11.
//

import UIKit

class AreaViewController: UIViewController {
    // MARk: - IBOutlet
    @IBOutlet var backBTN: UIButton!
    @IBOutlet var AreaLabel: UILabel!
    @IBOutlet var TView: UITableView!
    // MARK: - Proprtty
    var weatherData2: weatherData?
    var selectedArea: String?



    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI()
        
        tableSet()
        print("AreaViewController - viewDidLoad, 選擇的區域: \(selectedArea ?? "未設置")")
        AreaLabel.text = selectedArea
        
        
        TView.reloadData()

    }

    // MARK: - UI Setting
    func tableSet() {
            TView.register(UINib(nibName: "AreaTableViewCell", bundle: nil), forCellReuseIdentifier: AreaTableViewCell.identifie)
            
            TView.dataSource = self
            TView.delegate = self
        }
    // MARK: - IBAction
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Function
    func callAPI() {
                
        let city = "\(selectedArea!)"
        let requestURL = LegitimateURL(requestURL: "https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-A4AA97C5-E3C1-4BEB-B730-688876F81863&locationName=" + city)
        
        URLSession.shared.dataTask(with: requestURL) { [self]
            (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response {
                print("====================")
                print(response as! HTTPURLResponse)
                print("====================")

            }
            
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    self.weatherData2 = try decoder.decode(weatherData.self, from: data)
                    
                    print("====================")
                    print(weatherData2 ?? "")
                    print("====================")
                    
                    //主線成
                    DispatchQueue.main.async {
                        self.TView.reloadData()
                    }
                    
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
    func LegitimateURL(requestURL: String) -> URL {
        let legitimateURL = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: legitimateURL!)
        return url!
    }
}
// MARK: - Extensions
extension AreaViewController: UITableViewDelegate, UITableViewDataSource{
    //cellForRowAt內容的設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TView.dequeueReusableCell(withIdentifier: AreaTableViewCell.identifie, for: indexPath) as! AreaTableViewCell
        let minT = weatherData2?.records.location[0].weatherElement[2].time[indexPath.row].parameter.parameterName ?? " "
        let maxT = weatherData2?.records.location[0].weatherElement[4].time[indexPath.row].parameter.parameterName ?? " "
     
            cell.timeLb.text = weatherData2?.records.location[0].weatherElement[0].time[indexPath.row].startTime ?? " "
            cell.cloudLb.text = weatherData2?.records.location[0].weatherElement[0].time[indexPath.row].parameter.parameterName ?? " "
            cell.minTLb.text = "\(maxT)°C "
            cell.feelLb.text = weatherData2?.records.location[0].weatherElement[3].time[indexPath.row].parameter.parameterName ?? " "
        cell.maxTLb.text = "\(minT)°C"
            return cell
       
    }
    //numberOfRowsInSection顯示的行數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}
