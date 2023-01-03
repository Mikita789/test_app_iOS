//
//  ThreeViewController.swift
//  onlyTestApp
//
//  Created by Никита Попов on 24.12.22.
//

import UIKit

class ThreeViewController: UIViewController {
    var imageView = UIImageView()
    var startIm = UIImage(named: "mars")
    var netwManager = ParseModelNasa()
    var datePicker = UIDatePicker()
    var currentDate = Date()
    var dateFormater = DateFormatter()
    var selectDate = ""
    var infoLabel = UILabel()
    var selectDateLabel = UILabel()
    var urlImageTexrView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "NASA Photo of the Day"
        dateFormater.dateFormat = "yyyy-MM-dd"
        selectDate = dateFormater.string(from: currentDate)
        
        
        //MARK: Create imageView
        self.imageView = UIImageView(image: startIm)
        self.imageView.center.x = self.view.center.x
        self.imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height*0.03).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        self.imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.45).isActive = true
        
        netwManager.resultNASAPhoto = {result in
            self.updateImNasa(target: result)
        }
        netwManager.nasaPhoto(date: selectDate)
        
        //MARK: Create dataPicker
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = .date
        self.datePicker.addTarget(self, action: #selector(datePickAction), for: .valueChanged)
        self.view.addSubview(datePicker)
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.1).isActive = true
        self.datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.bounds.width*0.03).isActive = true
        self.datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        self.datePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
        
        //MARK: create infoLabel
        self.infoLabel = UILabel()
        self.infoLabel.numberOfLines = .max
        self.infoLabel.textAlignment = .justified
        self.infoLabel.contentMode = .scaleAspectFit
        self.infoLabel.minimumScaleFactor = 0.4
        self.infoLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(infoLabel)
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: view.bounds.height*0.01).isActive = true
        self.infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.infoLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        //MARK: create selectDateLabel
        self.selectDateLabel = UILabel()
        self.selectDateLabel.text = "Select date:"
        self.selectDateLabel.adjustsFontSizeToFitWidth = true
        self.selectDateLabel.textAlignment = .right
        self.view.addSubview(selectDateLabel)
        self.selectDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectDateLabel.rightAnchor.constraint(equalTo: datePicker.leftAnchor, constant: -view.bounds.width*0.01).isActive = true
        self.selectDateLabel.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor, constant: 0).isActive = true
        self.selectDateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        self.selectDateLabel.heightAnchor.constraint(equalToConstant: datePicker.bounds.height).isActive = true
        
        
        //MARK: create url textView
        self.urlImageTexrView = UITextView()
        self.urlImageTexrView.text = ""
        self.urlImageTexrView.dataDetectorTypes = .link
        self.urlImageTexrView.textAlignment = .center
        self.view.addSubview(urlImageTexrView)
        self.urlImageTexrView.translatesAutoresizingMaskIntoConstraints = false
        self.urlImageTexrView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: view.bounds.height*0.005).isActive = true
        self.urlImageTexrView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        self.urlImageTexrView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: self.view.bounds.width*0.08).isActive = true
        self.urlImageTexrView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.025).isActive = true
        self.urlImageTexrView.isEditable = false
        

    }
    
    //MARK: func update UI
    private func updateImNasa(target: Nasa){
        DispatchQueue.main.async {
            self.urlImageTexrView.text = "HD Photo: \(target.hdurl)"
            self.infoLabel.text = target.explanation
            if let urlIm = URL(string: target.url){
                URLSession.shared.dataTask(with: urlIm, completionHandler: {data, resp, err in
                    guard let data = data else {return}
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }).resume()
            }
        }
            
    }
    
    @objc func datePickAction(target: UIDatePicker){
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        self.selectDate = (formater.string(from: target.date))
        netwManager.nasaPhoto(date: selectDate)
    }
    

}
