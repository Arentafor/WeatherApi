import UIKit

class ForecastWeatherWithoutAlomafireViewController: UIViewController {

    @IBOutlet var weatherTable: UITableView!
    
    
    var forecast: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = CategoriesLoader()
        loader.delegate = self
        loader.loadDays()
    }
}
extension ForecastWeatherWithoutAlomafireViewController: DaysLoaderDelegate {
    func loaded(days: [Category]) {
        self.forecast = days
        weatherTable.reloadData()
    }
}
extension ForecastWeatherWithoutAlomafireViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! ForecastWTableViewCell
        
       let cat = forecast[indexPath.row]
        
        cell.temperature.text = String(Int(cat.temp))
        cell.datee.text = cat.date
        cell.typeWeather.text = cat.clouds
        cell.wind.text = String(cat.wind)
        return cell
    }
    
   
    
    
    
    
}
