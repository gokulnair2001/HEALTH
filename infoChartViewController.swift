//
//  infoChartViewController.swift
//  HEALTH
//
//  Created by Gokul Nair on 03/06/21.
//

import UIKit

class infoChartViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var vitaminSlider: UIProgressView!
    @IBOutlet weak var carbSlider: UIProgressView!
    @IBOutlet weak var fatSlider: UIProgressView!
    @IBOutlet weak var proteinSlider: UIProgressView!
    @IBOutlet weak var calSlider: UIProgressView!
    
    var Content:[Float] = [2,9,2,4,1,6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = 15
//        bgView.layer.borderWidth = 3
//        bgView.layer.borderColor = UIColor.black.cgColor
        sliderUpdate()
    }
    
    func sliderUpdate() {
        vitaminSlider.progress = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vitaminSlider.setProgress(self.Content[0]/10, animated: true)
            self.carbSlider.setProgress(self.Content[1]/10, animated: true)
            self.fatSlider.setProgress(self.Content[2]/10, animated: true)
            self.proteinSlider.setProgress(self.Content[3]/10, animated: true)
            self.calSlider.setProgress(self.Content[4]/10, animated: true)
        }
    }
}
