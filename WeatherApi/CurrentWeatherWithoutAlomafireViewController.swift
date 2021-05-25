//
//  CurrentWeatherWithoutAlomafireViewController.swift
//  WeatherApi
//
//  Created by Виталий Крюков on 13.05.2021.
//

import UIKit

class CurrentWeatherWithoutAlomafireViewController: UIViewController {
    
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var NameLabel: UILabel!
    @IBOutlet var TypeWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoaderCurWeather()
    }
    
    
    func LoaderCurWeather() {
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=524894&appid=16ed32a32efe13bdf50928acc3347046")!

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                DispatchQueue.main.async {
                  let jsondict = json as! NSDictionary
                    
                    let containerDataWeather = jsondict["weather"] as! [NSDictionary]
                    self.TypeWeatherLabel.text = containerDataWeather[0]["description"] as? String
                    self.NameLabel.text = "Current weather in \(jsondict["name"] as! String)"
                    let containerTemp = jsondict["main"] as! NSDictionary
                    let tempKelvin = Int(containerTemp["temp"] as! Double)
                    self.temperatureLabel.text = "\(tempKelvin - 273)"
                }
            }
        }
        task.resume()
    }
 
    
}

