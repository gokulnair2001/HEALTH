//
//  calorieMeterViewController.swift
//  HEALTH
//
//  Created by Gokul Nair on 02/06/21.
//

import UIKit
import Loafjet

class calorieMeterViewController: UIViewController, didUpdateVessel {
    func updateVessel(vesselQuantity: Int, imageofVessel: UIImage, vesselName: String) {
        selectedVessel.image  = imageofVessel
        containerName.text = vesselName
        containerQuantity.text = "Quantity: \(vesselQuantity) gm"
        selVesselQuantity = vesselQuantity
    }
    
    
    let foodDetector = foodClassifier()
   // let loadingIndicator = UIActivityIndicatorView()
    
    var selVesselQuantity:Int = 20
    
    @IBOutlet weak var selectedVessel: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var containerName: UILabel!
    @IBOutlet weak var containerQuantity: UILabel!
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var perCalLbl: UILabel!
    @IBOutlet weak var totalCalLbl: UILabel!
    @IBOutlet weak var foodInfo: UITextView!
    @IBOutlet weak var itemName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = 10
        infoButton.layer.cornerRadius = 5

       
    }
    
    @IBAction func moreInfoBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "infoViewss") as! infoChartViewController
        vc.modalPresentationStyle = .formSheet
        navigationController?.present(vc, animated: true, completion: nil)
    }
    @IBAction func selectImage(_ sender: Any) {
        
        setupImageSelection()
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(identifier: "vessel") as vesselViewController
        vc.vesselSelectionDelegate = self
        vc.modalPresentationStyle = .formSheet
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

extension calorieMeterViewController {
    func imageClassifier(){
        
        var inputImage = [foodClassifierInput]()
        
        if imageData.image != nil{
            let newImage =  buffer(from: imageData.image!)
            let imageForClassification = foodClassifierInput(image: newImage!)
            inputImage.append(imageForClassification)
        }
        
        do {
            let prediction = try self.foodDetector.predictions(inputs: inputImage)
            
            for result in prediction{
                let res = result.classLabel
                
                if res == "Apple"{
                    itemName.text = "Apple"
                    perCalLbl.text = "1"
                    totalCalLbl.text = "\(selVesselQuantity)"
                    foodInfo.text = "An apple is an edible fruit produced by an apple tree (Malus domestica). Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus. The tree originated in Central Asia, where its wild ancestor, Malus sieversii, is still found today. Apples have been grown for thousands of years in Asia and Europe and were brought to North America by European colonists. Apples have religious and mythological significance in many cultures, including Norse, Greek, and European Christian tradition."
                }
                else if res == "Grapes"{
                    itemName.text = "Grapes"
                    perCalLbl.text = "2"
                    totalCalLbl.text = "\(selVesselQuantity*2)"
                    foodInfo.text = "A grape is a fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis. Grapes can be eaten fresh as table grapes or they can be used for making wine, jam, grape juice, jelly, grape seed extract, raisins, vinegar, and grape seed oil. Grapes are a non-climacteric type of fruit, generally occurring in clusters."
                }
                else{
                    
                }
            }
            
        }catch{
            print("error found\(error)")
        }
    }
}

extension calorieMeterViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imageData.image = image
        Loaf.LoafWheel(message: "Foos is Being Processed!", loafWidth: 250, loafHeight: 100, cornerRadius: 17, bgColor1: .systemOrange, bgColor2: .systemYellow, fontStyle: "Avenir Medium", fontSize: 17, fontColor: .black, duration: 5, wheelStyle: .large, blurEffect: .light, loafWheelView: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.imageClassifier()
        })
    }
    
    func setupImageSelection(){
        UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
}

extension calorieMeterViewController{
    //MARK:- To convert uiimage to cvpixelbuffer
    
    func buffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}
