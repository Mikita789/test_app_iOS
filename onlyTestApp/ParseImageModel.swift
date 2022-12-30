//
//  ParseImageModel.swift
//  onlyTestApp
//
//  Created by Никита Попов on 16.12.22.
//
//
import Foundation
import UIKit

// MARK: - RandomDog
struct RandomDog: Codable {
    let url: String
}


struct ImageHTML{
    
    
    var resultIm:((RandomDog)->Void?)?
    private func parseImageHTML(imageData:Data)->RandomDog?{
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(RandomDog.self, from: imageData) else {return nil}
        return result
    }
    
    func imageData(){
        guard let url = URL(string: "https://random.dog/woof.json") else {return}
        let _ = URLSession.shared.dataTask(with: url, completionHandler: {data, resp, err in
            guard let data = data else{return }
            guard let result = parseImageHTML(imageData: data) else {return}
            //print(result.url)
            resultIm?(result)
        }).resume()
    }
    
}


