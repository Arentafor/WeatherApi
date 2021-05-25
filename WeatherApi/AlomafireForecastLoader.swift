//
//  AlomafireForecastLoader.swift
//  WeatherApi
//
//  Created by Виталий Крюков on 24.05.2021.
//

import Foundation
import Alamofire


protocol AlomafireLoadDelegate {
    func alLoaded(AlomafireData:[AlomafireDatas])
}

class AlomafireLoadData {
    
    var alDelegate: AlomafireLoadDelegate?
    
    func AlomafireLoader() {
        AF.request("https://api.openweathermap.org/data/2.5/forecast?id=524894&appid=16ed32a32efe13bdf50928acc3347046").responseJSON { data in
            if let objects = data.value,
            let jsonDict = objects as? NSDictionary,
            let jsonArray = jsonDict["list"] as? NSArray {
                DispatchQueue.main.async {
                    
                    var categories: [AlomafireDatas] = []
                    for dict in jsonArray{
                        if let category = AlomafireDatas(data: dict as! NSDictionary){
                            categories.append(category)
                        }
                    }
                    self.alDelegate?.alLoaded(AlomafireData: categories)
                }
            }
        }
        
    }
}



class AlomafireDatas {

    var temp: Double

    var wind: Double

    var clouds: String

    var date: String

    

    init?(data: NSDictionary){

        guard let containerTemp = data["main"] as? NSDictionary,

            let temp = containerTemp["temp"] as? Double,

            let containerClouds = data["weather"] as? [NSDictionary],

            let clouds = containerClouds[0]["description"] as? String,

            let containerWind = data["wind"] as? NSDictionary,

            let wind = containerWind["speed"] as? Double,

            let date = data["dt_txt"] as? String else {return nil}

        self.temp = temp - 273.15

        self.clouds = clouds

        self.wind = wind

        self.date = date

    }

}

