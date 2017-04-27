//
//  ViewController.swift
//  simple-calc
//
//  Created by Brandon Chen on 4/15/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyViewController = segue.destination as! HistoryViewController
        historyViewController.data = history
    }
    @IBAction func Clear(_ sender: UIButton) {
        refresh()
        result.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var result: UILabel!
    
    func refresh() {
        equation = ""
        current = ""
        op = ""
        result.text = "0"
        clearNext = true
        input = []
    }
    
    var history: [String] = []
    var equation: String = ""
    var input: [Double] = []
    var current = ""
    var op: String = ""
    var clearNext: Bool = true
    
    let standard: [String] = ["+", "-", "/", "*", "%"] // all two number calculator functions
    let multi: [String] = ["Avg", "Count"] // multi value calculator functions
    let numeric: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."] // numbers and decimal
    
    func finalize(result: Double) {
        equation += current + "=" + String(result)
        history.append(equation)
        refresh()
        self.result.text = String(result)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let button: String = sender.titleLabel!.text!
        
        if numeric.contains(button) { // ensure that current will only be in the form of a double
            if clearNext {
                result.text = ""
                clearNext = false
            }
            if !current.contains(".") || button != "." { // no multiple decimals
                current += button
                if result.text == "0" {
                    result.text = button
                } else {
                    result.text = result.text! + button
                }
            }
        } else { // non numeric
            if button == "=" {
                var result: Double = 0
                if op != "" {
                    if standard.contains(op) { // standard requires input to contain one, current != ""
                        if input.count == 1, let b = Double(current) { // safe to evaluate
                            switch op {
                            case "+":
                                result = add(a: input[0], b: b)
                            case "-":
                                result = sub(a: input[0], b: b)
                            case "/":
                                result = div(a: input[0], b: b)
                            case "*":
                                result = mult(a: input[0], b: b)
                            case "%":
                                result = mod(a: input[0], b: b)
                            default:// shouldnt reach here
                                break
                            }
                            finalize(result: result)
                        }
                    } else if multi.contains(op) {
                        if let b = Double(current) {
                            input.append(b)
                            if op == "Avg" {
                                let result = average(a: input)
                                finalize(result: result)
                            } else if op == "Count" {
                                let result = count(a: input)
                                finalize(result: result)
                            }
                        }
                    }
                } // else do nothing, premature = press
            }
            if multi.contains(op) && button != op { // dont switch operations
                return
            } else if standard.contains(op) { // cannot switch from standard
                return
            }
            if standard.contains(button) {
                if let b = Double(current) {
                    input.append(b)
                    op = button
                    equation = current + op
                    current = ""
                    clearNext = true
                }
            } else if multi.contains(button) {
                if let b = Double(current) {
                    input.append(b)
                    op = button
                    equation += current + op
                    current = ""
                    clearNext = true
                }
            } else if button == "Fact" {
                if let b = Double(current) {
                    let result = fact(b)
                    current += "Fact"
                    finalize(result: result)
                    clearNext = true
                }
            }
        }
    }
    
    // Calculator functions
    func add(a: Double, b: Double) -> Double {
        return(a + b)
    }
    func sub(a: Double, b: Double) -> Double{
        return(a - b)
    }
    func mult(a: Double, b: Double) -> Double {
        return(a * b)
    }
    func div(a: Double, b: Double) -> Double {
        return(a / b)
    }
    func mod(a: Double, b: Double) -> Double {
        return(a.truncatingRemainder(dividingBy: b))
    }
    func fact(_ n: Double) -> Double {
        if(n < 0) {
            return -1
        }
        if(n == 0) {
            return 1;
        }
        return n * fact(n-1);
    }
    func average(a: [Double]) -> Double {
        return avg2(a: a, b: true)
    }
    func count(a: [Double]) -> Double {
        return avg2(a: a, b: false)
    }
    
    // a: [String]  The array to find the average count of
    // b: Bool      Whether the average or count is printed
    func avg2(a: [Double], b: Bool) -> Double {
        let c = Double(a.count)
        var sum: Double = 0;
        for n in a {
            sum += n
        }
        if(b) {
            return (sum / c)
        } else {
            return (c)
        }
    }
}

