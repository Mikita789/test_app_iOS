//
//  Weather.swift
//  onlyTestApp
//
//  Created by Никита Попов on 13.12.22.
//

import Foundation
import UIKit

struct CurrencyWeather:Codable{
    let main: Main
}
// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}


public struct WeatherDataParse{
    var currentWeather:((CurrencyWeather)->Void)?
    
    func weatherData(){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=minsk&appid=a9a0b74f3e9fa3791aba58556db76d6f") else {return}
        let _ = URLSession.shared.dataTask(with: url, completionHandler: {data, resp, err in
            guard let data = data else {return}
            guard let result = jsParse(data: data) else {return}
            self.currentWeather?(result)
        }).resume()
    }
    
    private func jsParse(data:Data)->CurrencyWeather?{
        let decoder = JSONDecoder()
        guard let weatherData = try? decoder.decode(CurrencyWeather.self, from: data) else {return nil}
        return weatherData
                
    }
    
    
}


