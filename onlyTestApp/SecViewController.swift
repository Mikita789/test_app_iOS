//
//  SecViewController.swift
//  onlyTestApp
//
//  Created by Никита Попов on 16.12.22.
//

import UIKit

class SecViewController: UIViewController {
    
    var imageView = UIImageView()
    var startImage = UIImage(named: "злой")
    var netwImageHTML = ImageHTML()
    var nextScreenButton = UIButton()
    var refrImageButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Random Dog Image"
        //MARK: create start imageView
        self.imageView = UIImageView(image: startImage)
        self.imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.135).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height*0.1).isActive = true
        
        netwImageHTML.resultIm = {res in
            self.updateImage(data: res)
        }
        netwImageHTML.imageData()

        self.view.backgroundColor = .white
    
        //MARK: create refresh button
        self.refrImageButton = UIButton(type: .custom)
        self.refrImageButton.setImage(UIImage(named: "upd"), for: .normal)
        self.refrImageButton.imageView?.contentMode = .scaleAspectFit
        self.refrImageButton.setTitle("Refresh Image", for: .normal)
        self.refrImageButton.setTitleColor(.black, for: .normal)
        self.refrImageButton.addTarget(self, action: #selector(refrButton), for: .touchUpInside)
        self.view.addSubview(refrImageButton)
        self.refrImageButton.translatesAutoresizingMaskIntoConstraints = false
        self.refrImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.1).isActive = true
        self.refrImageButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        self.refrImageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width*0.1).isActive = true
        self.refrImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        
        
        //MARK: create next screen button
        self.nextScreenButton = UIButton(type: .custom)
        self.nextScreenButton.setTitle("NASA Screen", for: .normal)
        self.nextScreenButton.setTitleColor(.black, for: .normal)
        self.nextScreenButton.backgroundColor = .white
        self.nextScreenButton.contentHorizontalAlignment = .right
        self.nextScreenButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.nextScreenButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
        self.view.addSubview(nextScreenButton)
        self.nextScreenButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextScreenButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height*0.004).isActive = true
        self.nextScreenButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.bounds.width*0.045).isActive = true
        self.nextScreenButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/25).isActive = true
        self.nextScreenButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
    }
    
    //MARK: next screen button action
    @objc func nextScreen(target: UIButton){
        let vc = ThreeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refrButton(target: UIButton){
        netwImageHTML.imageData()
    }
    
    
    //MARK: Create func update UI
    private func updateImage(data:RandomDog){
        DispatchQueue.main.async {
            if let urlIm = URL(string: data.url){
                URLSession.shared.dataTask(with: urlIm, completionHandler: {data, resp, err in
                    guard let imageData = data else {return}
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: imageData)
                    }
                }).resume()
                
            }
            
        }
    }

}
