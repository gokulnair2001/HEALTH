//
//  ViewController.swift
//  HEALTH
//
//  Created by Gokul Nair on 02/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImg.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    }

    

}

