//
//  ViewController.swift
//  CompletionHandler
//
//  Created by Josh Kneedler on 12/21/18.
//  Copyright © 2018 Josh Kneedler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var iDrive: InfiniteDrive? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        iDrive = InfiniteDrive()
        iDrive?.startDrive()
    }


}

