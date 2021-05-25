//
//  AlCurrentViewController.swift
//  WeatherApi
//
//  Created by Виталий Крюков on 25.05.2021.
//

import UIKit
import Alamofire

class AlCurrentViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var temperatureLabel: UILabel!
    
    @IBOutlet var typeweatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alLoaderCurWeather()
        
    }

    func alLoaderCurWeather() {
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?id=524894&appid=16ed32a32efe13bdf50928acc3347046").responseJSON { data in
            
            if let objects = data.value{
                
                DispatchQueue.main.async {
                  let jsondict = objects as! NSDictionary
                    
                    let containerDataWeather = jsondict["weather"] as! [NSDictionary]
                    self.typeweatherLabel.text = containerDataWeather[0]["description"] as? String
                    self.nameLabel.text = "Current weather in \(jsondict["name"] as! String)"
                    let containerTemp = jsondict["main"] as! NSDictionary
                    let tempKelvin = Int(containerTemp["temp"] as! Double)
                    self.temperatureLabel.text = "\(tempKelvin - 273)"
                }
            }
        }
    }
}
