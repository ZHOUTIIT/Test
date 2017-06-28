//
//  ViewController.swift
//  newiOS
//
//  Created by Zhou Ti on 23/6/17.
//  Copyright © 2017 com.MMT-AGENT. All rights reserved.
//

import UIKit

var operation: ((Double, Double) -> Double)? = nil
class ViewController: UIViewController {

    var a: Double = 0.0
    var clear: Bool = false
    var second: Bool = false
    @IBOutlet weak var result: UILabel!

    @IBAction func number(_ sender: UIButton) {
        if !clear {
            if result.text == "0" && sender.titleLabel!.text! != "." {
                result.text = sender.titleLabel!.text!
            } else {
                result.text! += sender.titleLabel!.text!
            }
        } else {
            result.text = sender.titleLabel!.text!
            clear = false
        }
    }

    func add(a: Double, b: Double) -> Double {
        return a + b
    }
    func minus(a: Double, b: Double) -> Double {
        return a - b
    }
    func times(a: Double, b: Double) -> Double {
        return a * b
    }
    func divide(a: Double, b: Double) -> Double {
        return a / b
    }

    @IBAction func operate(_ sender: UIButton) {
        switch sender.titleLabel!.text! {
        case "-":
            a = Double(result.text!)!
            clear = true
            second = true
            operation = minus
        case "+":
            a = Double(result.text!)!
            clear = true
            second = true
            operation = add
        case "x":
            a = Double(result.text!)!
            clear = true
            second = true
            operation = times
        case "/":
            a = Double(result.text!)!
            clear = true
            second = true
            operation = divide
        default:
            break
        }
    }

    @IBAction func equal(_ sender: UIButton) {
        if !second {
            return
        }
        result.text = String(operation!(a, Double(result.text!)!))
        second = false
    }

    @IBAction func ac(_ sender: UIButton) {
        result.text = "0"
        a = 0.0
    }
}
