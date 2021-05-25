//
//  AlomafireForecastViewController.swift
//  WeatherApi
//
//  Created by Виталий Крюков on 24.05.2021.
//

import UIKit

class AlomafireForecastViewController: UIViewController {
    
    var alForecast: [AlomafireDatas] = []
 
    @IBOutlet var AlTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       let alLoader = AlomafireLoadData()
        alLoader.alDelegate = self
        alLoader.AlomafireLoader()
        


    }
    
}
extension AlomafireForecastViewController: AlomafireLoadDelegate {
    func alLoaded(AlomafireData: [AlomafireDatas]) {
        self.alForecast = AlomafireData
        AlTableView.reloadData()
    }
 
}

extension AlomafireForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlomafireCell", for: indexPath) as! AlomafireTableViewCell
        
       let cat = alForecast[indexPath.row]
        
        cell.temperatureLabel.text = String(Int(cat.temp))
        cell.dateLabel.text = cat.date
        cell.typeWeather.text = cat.clouds
        cell.windLabel.text = String(cat.wind)
        return cell
    }
}


