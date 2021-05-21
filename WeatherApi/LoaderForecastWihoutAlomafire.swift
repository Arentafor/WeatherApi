import Foundation

protocol DaysLoaderDelegate {
    func loaded(days:[Category])
}

class CategoriesLoader {
    
    var delegate: DaysLoaderDelegate?
    
    func loadDays(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=524894&appid=16ed32a32efe13bdf50928acc3347046")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary,
               let jsonDict = json["list"] as? NSArray {
            
                DispatchQueue.main.async {
                    var categories: [Category] = []
                    for dict in jsonDict{
                        if let category = Category(data: dict as! NSDictionary){
                            categories.append(category)
                            print(categories.count)
                        }
                    }
                    self.delegate?.loaded(days: categories)
                }
            }
        }
        task.resume()
    }
}

