//
//  secondView.swift
//  Lab 1
//
//  Created by Paul Angelo Sy on 2/24/23.
//

import Foundation
import UIKit

class secondView: UIViewController{
    
    var img = UIImage()
    var name = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondImage.image = img
        secondLabel.text = name
    }
    
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
}
