//
//  vesselViewController.swift
//  HEALTH
//
//  Created by Gokul Nair on 02/06/21.
//

import UIKit

class vesselViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tapViewAdded: UIView!
    
    let tapGest = UITapGestureRecognizer()
    
    var vesselImage:[UIImage] = [#imageLiteral(resourceName: "v1"),#imageLiteral(resourceName: "v2"),#imageLiteral(resourceName: "v3")]
    var vesselName:[String] = ["Round Bowl","Usual Bowl","Office Tiffin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        bgView.layer.cornerRadius = 20
        
        tapViewAdded.addGestureRecognizer(tapGest)
        view.addSubview(bgView)
        tapGest.cancelsTouchesInView = false
        tapGest.addTarget(self, action: #selector(dismissMethod))
        
    }
    
    @objc func dismissMethod() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension vesselViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vesselName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! vesselCollectionViewCell
        cell.imageVessel.image = vesselImage[indexPath.row]
        cell.vesselName.text = vesselName[indexPath.row]
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
