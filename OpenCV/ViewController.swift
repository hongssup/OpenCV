//
//  ViewController.swift
//  OpenCV
//
//  Created by SeoYeon Hong on 2021/08/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sourceView: UIImageView!
    @IBOutlet weak var targetView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //targetView.image = OpenCVWrapper.toGray(sourceView.image!)
        targetView.image = OpenCVWrapper.getContours(sourceView.image!)
    }
    


}

