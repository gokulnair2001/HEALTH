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
        sliderUpdate()
    }
    
    func sliderUpdate() {
        vitaminSlider.progress = 0
        
        if calorieMeterViewController.itemIdentified == "Apple" {
            arrayOf(selecItemArray: [2,9,2,4,1,6])
        }else {
            arrayOf(selecItemArray: [2,7,3,5,6,6])
        }
    }
    
    func arrayOf(selecItemArray: [Float]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vitaminSlider.setProgress(selecItemArray[0]/10, animated: true)
            self.carbSlider.setProgress(selecItemArray[1]/10, animated: true)
            self.fatSlider.setProgress(selecItemArray[2]/10, animated: true)
            self.proteinSlider.setProgress(selecItemArray[3]/10, animated: true)
            self.calSlider.setProgress(selecItemArray[4]/10, animated: true)
        }
    }
}
