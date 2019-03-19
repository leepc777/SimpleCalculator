//
//  Calculations.swift
//  SimpleCaculator
//
//  Created by sam on 3/19/19.
//  Copyright © 2019 patrick. All rights reserved.
//

import Foundation

struct Calculations {
    
    private var number : Double?
    
    private var intermediateCalculation : (n1:Double,calMethod:String)?
    
    mutating func setNumber(_ number:Double) {
        self.number = number
    }
    
    mutating func calculate(symbol:String) -> Double? {
        
        guard let n = number else {return nil}
        
        switch symbol {
        case "+/-":
            return n * -1
        case "AC":
            intermediateCalculation = nil
            return 0
        case "%":
            return n * 0.01
        case "=":
            print("you tapped = ")
//            defer  {intermediateCalculation = nil}
            return perform2NumCalculation(n2: n)
            
        default:
            // if there is undone calculation stored in tuple already, +-*/ will do the calculation and update the tuple.
            if let intermida = intermediateCalculation {
                return performContinuingCalculation(n2: n)
            }
            else {
            // if there is no undone calculation in tuple, +-*/ will just update the tuple without caculation until users tapping = 
            intermediateCalculation = (n1: n, calMethod: symbol)
            }
//            return performContinuingCalculation(n2: n)
        }
        
        return nil
    }
    
    private mutating func perform2NumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,let operation = intermediateCalculation?.calMethod {
            
            switch operation {
            case "+" :
                intermediateCalculation = nil
//                defer {intermediateCalculation!.n1 = n1+n2}
                return n1 + n2
            case "−" :
                intermediateCalculation = nil
                return n1 - n2
            case "×" :
                intermediateCalculation = nil
                return n1 * n2
            case "÷" :
                intermediateCalculation = nil
                return n1 / n2
            default:
                fatalError("The operation passed in is not + - * /")
            }
        }
//        intermediateCalculation!.n1 = 0
        return nil
    }
    
    
    
    private mutating func performContinuingCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,let operation = intermediateCalculation?.calMethod {
            
            switch operation {
            case "+" :
                defer{
//                    print("defer got called intermediateCalculation!.n1=\(intermediateCalculation!.n1) ,\(n1) ,\(n2)")
                intermediateCalculation!.n1 = n1+n2
                intermediateCalculation!.calMethod = "+"
                //                defer {intermediateCalculation!.n1 = n1+n2}
                }
                return n1 + n2
            case "−" :
                defer {
                intermediateCalculation!.n1 = n1-n2
                intermediateCalculation!.calMethod = "−"
                }
                return n1 - n2
            case "×" :
                defer {
                intermediateCalculation!.n1 = n1*n2
                    intermediateCalculation!.calMethod = "×"
                    
                }
                return n1 * n2
            case "÷" :
                defer {
                intermediateCalculation!.n1 = n1/n2
                intermediateCalculation!.calMethod = "÷"
                }
                return n1 / n2
            default:
                fatalError("The operation passed in is not + - * /")
            }
        }
        //        intermediateCalculation!.n1 = 0
        return nil
    }

    
    
}
