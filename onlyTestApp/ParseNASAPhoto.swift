//
//  ParseNASAPhoto.swift
//  onlyTestApp
//
//  Created by Никита Попов on 24.12.22.
//

import Foundation


// MARK: - Nasa
struct Nasa: Codable {
    let date, explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}


struct ParseModelNasa {
    var resultNASAPhoto:((Nasa)->Void)?
    private func JSpars(data: Data)->Nasa?{
        let decoder = JSONDecoder()
        let result = try? decoder.decode(Nasa.self, from: data)
        return result
    }
    
    func nasaPhoto(date: String = "2022-12-12"){
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=9DqfrbytwQ3RrsVATsfvf04aT5MT50cN0L6JuBDx&hd=true&date=\(date)") else {return}
        
        let _ = URLSession.shared.dataTask(with: url, completionHandler: {data, resp, error in
            guard let data = data else {return}
            guard let result = JSpars(data: data) else {return}
            self.resultNASAPhoto?(result)
        }).resume()
    }
    
}
