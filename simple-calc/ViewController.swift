//
//  ViewController.swift
//  simple-calc
//
//  Created by Brandon Chen on 4/15/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        print("The button was pressed")
    }

}

