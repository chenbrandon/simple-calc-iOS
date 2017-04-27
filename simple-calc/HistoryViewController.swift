//
//  HistoryViewController.swift
//  simple-calc
//
//  Created by Brandon Chen on 4/26/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        list.contentSize = CGSize(width: list.frame.width, height: CGFloat(data.count*25))
        for i in 0..<data.count {
            let item = UILabel(frame: CGRect(x: 0,y: i * 25 ,width: Int(list.bounds.size.width),height: 30))
            item.textAlignment = NSTextAlignment.right
            item.text = data[i]
            list.addSubview(item)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var list: UIScrollView!
    
    var data: [String] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ViewController
        viewController.history = data
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
