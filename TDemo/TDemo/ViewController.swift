//
//  ViewController.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = UIImageView.default50x50()

        self.imageView = imageView
        
        self.view.addSubview(imageView)
        
        self.setImage()
    }

    func setImage() {
        
        let image = UIImage.image50x50(color: .random())
        
        self.imageView.image = image
        
        weak var wSelf: ViewController? = self
        
        delay(1) {
            wSelf?.setImage()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

