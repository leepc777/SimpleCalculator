//
//  ViewController.swift
//  SimpleCaculator
//
//  Created by sam on 3/18/19.
//  Copyright © 2019 patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //makes global variable isFinishedTypingNumber private so it can only be accessed inside this class
    // a tracker to keep trakcing typing number has been done
    // when typing is down, display the new single bit number
    // when typing is still going, cancaternate the single bit number to previous number.
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let value = Double(displayLabel.text!) else {
                fatalError("can't convert displayLabel.text to a Double")
            }
            return value
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    var displayNumber : String = ""

    @IBOutlet weak var displayLabel: UILabel!
    
    
    // must use var in order to pass number to instance property number in struct
    private var calculator = Calculations()

    @IBAction func calcButtonTapped(_ sender: UIButton) {
        isFinishedTypingNumber = true
        
        guard let calMethod = sender.currentTitle else {
            fatalError(" calButtom.currentTitle as nil")
        }
        
//        let calculator = Calculations(number: displayValue)
        calculator.setNumber(displayValue)
        
        
        // can't use guard beacuse the result could be nil if users tap calc symbol without number first. So use if let instead
//        guard let result = calculator.calculate(symbol: calMethod) else {
//            fatalError("The result of calculation is nil")
//        }
        
        if let result = calculator.calculate(symbol: calMethod) {
        displayValue = result
        }
//        switch calMethod {
//        case "+/-":
//            displayValue *= -1
//        case "AC":
////            displayLabel.text = "0"
//            displayValue = 0
//        case "%":
//            displayValue *= 0.01
//        default:
//            ()
//        }
        
    }
    
    @IBAction func numButtonTapped(_ sender: UIButton) {

        guard let number = sender.currentTitle else {
            print(" number button doesn't have text")
            return
        }
        
        // when finishing typing number by tapping calc buttons,show the next number to label.
        if isFinishedTypingNumber {
            displayLabel.text = number
            isFinishedTypingNumber = false
        } else {
            // still typing the new number.
            
            // use floor to round double(remove decimal point).
            // the ideal is you can only add . to Int. But this is too complicated. No good
//            if number == "." {
//                let isInt = ( floor(displayValue) == displayValue )
//                if !isInt {return}
//            }
            
            if number == "." {
//            guard !displayLabel.text!.contains(".") else {return}
                if displayLabel.text!.contains(".") {return}
            }
            
            displayLabel.text = displayLabel.text! + number
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

