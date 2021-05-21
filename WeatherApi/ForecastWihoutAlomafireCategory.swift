import Foundation //НОВЫЙ


class Category {

    

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

            let date = data["dt_txt"] as? String else{

                return nil

            }

        self.temp = temp - 273.15

        self.clouds = clouds

        self.wind = wind

        self.date = date

    }

}
