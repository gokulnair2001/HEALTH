//
//  calorieMeterViewController.swift
//  HEALTH
//
//  Created by Gokul Nair on 02/06/21.
//

import UIKit

class calorieMeterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(identifier: "vessel") as vesselViewController
        vc.modalPresentationStyle = .formSheet
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}
