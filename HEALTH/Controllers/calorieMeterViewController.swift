//
//  calorieMeterViewController.swift
//  HEALTH
//
//  Created by Gokul Nair on 02/06/21.
//

import UIKit

class calorieMeterViewController: UIViewController, didUpdateVessel {
    func updateVessel(vesselQuantity: Int, imageofVessel: UIImage, vesselName: String) {
        selectedVessel.image  = imageofVessel
        containerName.text = vesselName
        containerQuantity.text = "Quantity: \(vesselQuantity) gm"
    }
    
    
    let foodDetector = foodClassifier()
    
    @IBOutlet weak var selectedVessel: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var containerName: UILabel!
    @IBOutlet weak var containerQuantity: UILabel!
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moreInfoBtn(_ sender: Any) {
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
                   
                }
                else if res == "Grapes"{
                 
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
        DispatchQueue.main.async {
            self.imageClassifier()
        }
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
