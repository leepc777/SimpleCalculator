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
        print("mutating func setNumber(_ number:Double) got called. the passed number is \(number)")
        self.number = number
    }
    
    private var currentSymbol : String = ""
    private var isLastKeyInANumber : Bool = true

    
    // tapping any caculation buttons will trigger this
    mutating func calculate(symbol:String,isLastKeyInANumber:Bool) -> Double? {
        
        print("mutating func calculate(symbol:) -> Double, got called")
        currentSymbol = symbol
        
        // only when
        guard let n = number else {return nil}
        
        switch symbol {
        case "+/-":
//            if intermediateCalculation?.n1 != nil && intermediateCalculation?.calMethod == nil {
//            return n * -1
//            } else {
//                return nil
//            }
            
//            if intermediateCalculation != nil {
//                return nil
//            } else {
//                return n * -1
//            }
            
            return n * -1
        case "AC":
            intermediateCalculation = nil
            return 0
        case "%":
            return n * 0.01
        case "=":
            print("you tapped = ")
            defer  {intermediateCalculation = nil}
            return perform2NumCalculation(n2: n)
            
        default:
            // if there is undone calculation stored in tuple already, +-*/ will do the calculation and update the tuple.
            if intermediateCalculation != nil {
                // only do the calcuation when previous key in is a number.
                if isLastKeyInANumber {
                    return performContinuingCalculation(n2: n)
                // this is just user to overrite operators like 1 + * / 5. it is actually 1/5
                } else {
                    intermediateCalculation = (n1: n, calMethod: symbol)
                }
            }
            else {
            // if there is no undone calculation in tuple, +-*/ will just update the tuple without caculation until users tapping = 
            intermediateCalculation = (n1: n, calMethod: symbol)
            }
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
    
    
    //finish preivous undone caculation ( a tuple ) and update tuple with new n1 and symbol
    private mutating func performContinuingCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,let operation = intermediateCalculation?.calMethod {
            
            switch operation {
            case "+" :
                defer{
//                    print("defer got called intermediateCalculation!.n1=\(intermediateCalculation!.n1) ,\(n1) ,\(n2)")
                intermediateCalculation!.n1 = n1+n2
                intermediateCalculation!.calMethod = currentSymbol
                //                defer {intermediateCalculation!.n1 = n1+n2}
                }
                return n1 + n2
            case "−" :
                defer {
                intermediateCalculation!.n1 = n1-n2
                intermediateCalculation!.calMethod = currentSymbol
                }
                return n1 - n2
            case "×" :
                defer {
                intermediateCalculation!.n1 = n1*n2
                    intermediateCalculation!.calMethod = currentSymbol
                    
                }
                return n1 * n2
            case "÷" :
                defer {
                intermediateCalculation!.n1 = n1/n2
                intermediateCalculation!.calMethod = currentSymbol
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

extension Calculations {
    
    mutating func calculateNew (symbol:String,isLastKeyInANumber:Bool) -> (Double?) {
        
        print("mutating func calculate(symbol:) -> Double, got called")
        currentSymbol = symbol
        
        // only when
        guard let n = number else {return nil}
        
        switch symbol {
        case "+/-":
            //            if intermediateCalculation?.n1 != nil && intermediateCalculation?.calMethod == nil {
            //            return n * -1
            //            } else {
            //                return nil
            //            }
            
            //            if intermediateCalculation != nil {
            //                return nil
            //            } else {
            //                return n * -1
            //            }
            
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
            if intermediateCalculation != nil {
                // only do the calcuation when previous key in is a number.
                if isLastKeyInANumber {
                    return performContinuingCalculation(n2: n)
                    // this is just user to overrite operators like 1 + * / 5. it is actually 1/5
                } else {
                    intermediateCalculation = (n1: n, calMethod: symbol)
                }
            }
            else {
                // if there is no undone calculation in tuple, +-*/ will just update the tuple without caculation until users tapping =
                intermediateCalculation = (n1: n, calMethod: symbol)
            }
        }
        
        return nil
    }

    private mutating func performContinuingCalculationCH(n2: Double,completion:(Double,String)->Void) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,let operation = intermediateCalculation?.calMethod {
            completion(n1,operation)
            switch operation {
            case "+" :
                intermediateCalculation!.n1 = n1+n2
                intermediateCalculation!.calMethod = currentSymbol
                return n1 + n2
            case "−" :
                intermediateCalculation!.n1 = n1-n2
                intermediateCalculation!.calMethod = currentSymbol
                return n1 - n2
            case "×" :
                intermediateCalculation!.n1 = n1*n2
                intermediateCalculation!.calMethod = currentSymbol
                return n1 * n2
            case "÷" :
                intermediateCalculation!.n1 = n1/n2
                intermediateCalculation!.calMethod = currentSymbol
                return n1 / n2
            default:
                fatalError("The operation passed in is not + - * /")
            }
        }
        return nil
    }
    

    
    
}
