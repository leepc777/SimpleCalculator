//
//  ViewController.swift
//  SimpleCaculator
//
//  Created by sam on 3/18/19.
//  Copyright © 2019 patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //make isFinishedTypingNumber private so it can only be accessed inside this class
    // a tracker to keep trakcing typing number has been done
    // when typing is down, display the new single bit number
    // when typing is still going, cancaternate the single bit number to previous number.
    private var isFinishedTypingNumber: Bool = true
    
    
    var displayNumber : String = ""

    @IBOutlet weak var displayLabel: UILabel!
    
    
    @IBAction func calcButtonTapped(_ sender: UIButton) {
        isFinishedTypingNumber = true
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
//            displayNumber += number
//            displayLabel.text = displayNumber
            displayLabel.text = displayLabel.text! + number
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

