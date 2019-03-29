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
    
            var preValueString0 : String?
            var preSymbol : String?

    
//    var displayNumber : String = ""
    var isLastKeyInANumber : Bool = false

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var operatorLabel: UILabel!
    
    
    @IBOutlet var fourCalculations: [UIButton]!
    @IBOutlet weak var negativeSign: UIButton!
    @IBOutlet weak var persentSign: UIButton!
    @IBOutlet weak var equalSign: UIButton!
    
    
    // must use var in order to pass number to instance property number in struct
    private var calculator = Calculations()

    @IBAction func calcButtonTapped(_ sender: UIButton) {
//        isFinishedTypingNumber = true
//        isLastKeyInANumber = false
        
        guard let calMethod = sender.currentTitle else {
            fatalError(" calButtom.currentTitle as nil")
        }
        
//        enableCalButtons(false)
//        negativeSign.isUserInteractionEnabled = false
//        persentSign.isUserInteractionEnabled = false
//        equalSign.isUserInteractionEnabled = false
        
        operatorLabel.text = calMethod
        
        if let valueString = preValueString0 , let symbol = preSymbol
        {
            
        }
        
        
//        operatorLabel.text = "\(preValueString0) \(preSymbol)"
//        operatorLabel.text = "\(displayValue) " + calMethod
        print("tapped clcButtonTappeds",displayValue,calMethod)
//        let calculator = Calculations(number: displayValue)
        calculator.setNumber(displayValue)
        
        
        // can't use guard beacuse the result could be nil if users tap calc symbol without number first. So use if let instead
//        guard let result = calculator.calculate(symbol: calMethod) else {
//            fatalError("The result of calculation is nil")
//        }
        
        
        if let result = calculator.calculate(symbol: calMethod,isLastKeyInANumber:isLastKeyInANumber) {
        displayValue = result
            print(" <<< mutating func calculate(symbol:) return the result : \(result)")
        }
        
        // for trakcing previous number and operator
        preSymbol = sender.currentTitle
        if sender.currentTitle == "AC" {
            preValueString0 = nil
            preSymbol = nil
        }
        if isLastKeyInANumber {
            preValueString0 = displayLabel.text
        }
        
        isFinishedTypingNumber = true
        isLastKeyInANumber = false
    }
    
    @IBAction func numButtonTapped(_ sender: UIButton) {
//        var preValueString0 : String?
//        var preSymbol : String?
        
        operatorLabel.text = ""

        guard let number = sender.currentTitle else {
            print(" number button doesn't have text")
            return
        }
        print("  *** tapped numberButtons. preValueString0:\(preValueString0) preSymbol:\(preSymbol)")
        if let value = preValueString0,let symbol = preSymbol {
            print("   *** preValueString0:\(value)  preSymbol\(symbol) are not nil")
//            operatorLabel.text = "\(value) \(symbol) \t \t"
            
            // clear operatorLabel if tap a number after = 
            if symbol == "=" {
                operatorLabel.text = " "
            }
            else {
                operatorLabel.text = "\(value) \(symbol) \t \t"
            }

        }
//        enableCalButtons(true)
//        negativeSign.isUserInteractionEnabled = true
//        persentSign.isUserInteractionEnabled = true
//        equalSign.isUserInteractionEnabled = true

//        operatorLabel.text = ""
        
        // when finishing typing number by tapping calc buttons,show the next number to label.
        if isFinishedTypingNumber {
//            preValueString0 = displayLabel?.text
            preSymbol = operatorLabel?.text
            
            displayLabel.text = number
            isFinishedTypingNumber = false
        } else {
            // still typing the new number.
            
/*
             //use floor to round double(remove decimal point).
             //the ideal is you can only add . to Int. But this is too complicated. No good
            if number == "." {
                let isInt = ( floor(displayValue) == displayValue )
                if !isInt {return}
            }
*/
            
            // to prevent number has multiple .
            if number == "." {
//            guard !displayLabel.text!.contains(".") else {return}
                if displayLabel.text!.contains(".") {return}
            }
            
            // if Not finishing Typing Number yet, and not mulitiple . , then cancatenate new number
            displayLabel.text = displayLabel.text! + number
        }
        
        isLastKeyInANumber = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        for button in fourCalculations {
//            button.isEnabled = false
//            button.isUserInteractionEnabled = false
//            //            button.isHidden = false
////            button.isHighlighted = false
//        }

    }
    
    
    func enableCalButtons(_ yes:Bool) {
        
        if yes {
            for button in fourCalculations {
//                button.isEnabled = true
                button.isUserInteractionEnabled = true
//                button.isOpaque = false
                //            button.isHidden = true
                //            button.isHighlighted = false
            }
        } else {
            
            for button in fourCalculations {
//                button.isEnabled = false
                button.isUserInteractionEnabled = false
//                button.isOpaque = true
                //            button.isHidden = true
                //            button.isHighlighted = false
            }

        }
        
    }

}

