//
//  scoredistractionViewController.swift
//  ADHDbook
//
//  Created by emi oiso on 2024/11/16.
//

import UIKit

class scoreDistractionViewController: UIViewController {
    @IBOutlet weak var scoreDistractionLabel: UILabel!
    
    var correct = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreDistractionLabel.text = "\(correct)問正解!"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toTopButtouAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}
    
