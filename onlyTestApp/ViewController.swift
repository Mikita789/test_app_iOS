//
//  ViewController.swift
//  onlyTestApp
//
//  Created by Никита Попов on 13.12.22.
//

import UIKit
class ViewController: UIViewController {
    var weather = WeatherDataParse()
    var segmContr  = UISegmentedControl()
    var arrButton = ["добрый", "задумчивый", "злой"]
    var imageArr = [UIImage(named: "добрый"),
                    UIImage(named: "задумчивый"),
                    UIImage(named: "злой")]
    var imagView = UIImageView()
    var label = UILabel()
    var labelWeather = UILabel()
    var nextScreen = UIButton()
    var refrWeatherButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weather.currentWeather = { result in
            self.updateUI(data: result)
        }
        weather.weatherData()
        //MARK: create label
        self.label = UILabel()
        self.label.text = "А какой Паша Техник ты сегодня ?"
        self.label.font = label.font.withSize(25)
        self.label.contentMode = .scaleAspectFit
        self.label.textAlignment = .center
        self.label.numberOfLines = 2
        self.label.backgroundColor = .white
        self.view.addSubview(label)
        //MARK: add constraint Label
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.08).isActive = true
        self.label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width*0.05).isActive = true
        self.label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        self.label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
        
        //MARK: create button nextScreenButton
        self.nextScreen = UIButton(type: .custom)
        self.nextScreen.setTitleColor(.black, for: .normal)
        self.nextScreen.setTitle("Next Screen", for: .normal)
        self.nextScreen.backgroundColor = .white
        self.nextScreen.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.nextScreen.addTarget(self, action: #selector(nextScreenAction), for: .touchUpInside)
        self.nextScreen.contentMode = .scaleAspectFit
        self.view.addSubview(nextScreen)
        self.nextScreen.translatesAutoresizingMaskIntoConstraints = false
        //MARK: add constraint nextScreenButton
        self.nextScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height*0.004).isActive = true
        self.nextScreen.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.bounds.width*0.045).isActive = true
        self.nextScreen.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/25).isActive = true
        self.nextScreen.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        
                
        //MARK: create imageView
        self.imagView = UIImageView(image: imageArr[0])
        self.imagView.contentMode = .scaleAspectFit
        self.view.addSubview(imagView)
        //MARK: create imageView constraints
        self.imagView.translatesAutoresizingMaskIntoConstraints = false
        self.imagView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: view.bounds.height*0.01).isActive = true
        self.imagView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width*0.005).isActive = true
        self.imagView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.bounds.width*0.005).isActive = true
        self.imagView.bottomAnchor.constraint(equalTo: nextScreen.topAnchor, constant: -view.bounds.height*0.2).isActive = true
        
        //MARK: create segmetnControl
        self.segmContr = UISegmentedControl(items: arrButton)
        self.segmContr.addTarget(self, action: #selector(segmAction), for: .valueChanged)
        self.view.addSubview(segmContr)
        //self.segmContr.isHidden = true
        //MARK: Create constrains segmcontroll
        self.segmContr.translatesAutoresizingMaskIntoConstraints = false
        self.segmContr.topAnchor.constraint(equalTo: imagView.bottomAnchor, constant: view.bounds.height*0.02).isActive = true
        self.segmContr.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.segmContr.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width*0.04).isActive = true
        self.segmContr.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        
        
        //MARK: create WeatherLabel
        self.labelWeather = UILabel()
        self.labelWeather.text = " "
        self.labelWeather.textAlignment = .center
        self.labelWeather.numberOfLines = 1
        self.labelWeather.adjustsFontSizeToFitWidth = true
        self.view.addSubview(labelWeather)
        self.labelWeather.isHidden = false
        //MARK: create constraints Weather Label
        self.labelWeather.translatesAutoresizingMaskIntoConstraints = false
        self.labelWeather.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        self.labelWeather.topAnchor.constraint(equalTo: segmContr.bottomAnchor, constant: view.bounds.height*0.02).isActive = true
        self.labelWeather.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55).isActive = true
        
        
        //MARK: create refresh Weather button
        self.refrWeatherButton = UIButton(type: .system)
        self.refrWeatherButton.setImage(UIImage(named: "refr"), for: .normal)
        self.refrWeatherButton.contentMode = .scaleAspectFit
        self.refrWeatherButton.layer.borderWidth = 1
        self.refrWeatherButton.addTarget(self, action: #selector(refrWeatherAction), for: .touchUpInside)
        self.view.addSubview(refrWeatherButton)
        self.refrWeatherButton.isHidden = false
        self.refrWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        self.refrWeatherButton.centerYAnchor.constraint(equalTo: labelWeather.centerYAnchor).isActive = true
        self.refrWeatherButton.rightAnchor.constraint(equalTo: labelWeather.leftAnchor, constant: -view.bounds.width*0.02).isActive = true
        self.refrWeatherButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.02).isActive = true
        self.refrWeatherButton.widthAnchor.constraint(equalToConstant:  view.bounds.height*0.02).isActive = true
        
        
    }
    //MARK: func segmControl action
    @objc func segmAction(target:UISegmentedControl){
        let selectImageIndex = target.selectedSegmentIndex
        self.imagView.image = imageArr[selectImageIndex]
        
        
    }
    //MARK: create actinn refresh weather button
    @objc func refrWeatherAction(target: UIButton){
        self.weather.weatherData()
    }
    //MARK: Next screen button action
    @objc func nextScreenAction(target:UIButton){
        let screen = SecViewController()
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    private func updateUI(data:CurrencyWeather){
        DispatchQueue.main.async {
            let temp = data.main.temp
            self.labelWeather.text = "Кстати в Минске сейчас \(Int(temp - 273.15))º C"
                    }
    }
    

}





