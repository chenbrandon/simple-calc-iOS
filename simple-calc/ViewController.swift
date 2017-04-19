//
//  ViewController.swift
//  simple-calc
//
//  Created by Brandon Chen on 4/15/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func Clear(_ sender: UIButton) {
        refresh()
        lastAnswer = 0
        result.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var result: UILabel!
    
    var lastAnswer: Double = 0
    var input: [Double] = []
    var current = ""
    var op: String = ""
    var clearNext: Bool = true
    
    let operations:[String] = ["+", "-", "/", "*", "%", "Avg", "Count"]

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let button: String = sender.titleLabel!.text!
        if operations.contains(button) {
            op = button
            if (Double(current) != nil) {
                input.append(Double(current)!)
            } else {
                return
            }
            current = ""
            clearNext = true
        } else if button == "Fact" {
            input.append(Double(current)!)
            result.text = String(fact(input[0]))
            refresh()
        } else if button == "=" { // try to calculate
            if(op == "") {
                return
            } else if (current == "") {
                if op == "Count" {
                    lastAnswer = Double(input.count)
                    result.text = String(lastAnswer)
                    refresh()
                    input = []
                } else if op == "Avg" {
                    lastAnswer = average(input)
                    result.text = String(lastAnswer)
                    refresh()
                    input = []
                }
            } else {
            input.append(Double(current)!)
            if input.count == 2 {
            let a = input[0]
            let b = input[1]
            switch op {
            case "+":
                lastAnswer = a + b
            case "-":
                lastAnswer = a - b
            case "*":
                lastAnswer = a * b
            case "/":
                lastAnswer = a / b
            case "%":
                lastAnswer = a.truncatingRemainder(dividingBy: b)
            default:
                break
            }
                result.text = String(lastAnswer)
            }
            }
            refresh()
            input = []
        }else {  // not an operation, build number
            if(clearNext) {
                result.text = ""
                clearNext = !clearNext
            }
            current = current + button
            result.text = result.text! + button
        }
        
    }
    func fact(_ n: Double) -> Double {
        if(n <= 1) {
            return 1
        }
        return n * fact(n - 1)
    }
    func average(_ arr: [Double]) -> Double {
        var sum = 0.0
        for i in arr {
            sum += i
        }
        return sum / Double(arr.count)
    }
    
    func refresh() {
        current = ""
        op = ""
        clearNext = true
        input = []
    }

}

