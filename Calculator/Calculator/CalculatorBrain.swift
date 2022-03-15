//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Semih Emre ÜNLÜ on 26.12.2021.
//

import Foundation
class CalculatorBrain {
    
    private var accumulator: Double = 0
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func performOperation(_ operation: String?) {
        guard let operation = operation else { return }
        
        switch operation {
        case Operations.sqrt.rawValue:
            accumulator = sqrt(result)
        case Operations.percent.rawValue :
            accumulator = result / 100
        case Operations.log.rawValue :
            accumulator = log2(result)
        case Operations.CE.rawValue:
            //Action to clear the last number written
            accumulator = 0
        case Operations.C.rawValue :
            //Action to clear the last number written and last operation
            accumulator = 0
            UserDefaults.standard.set("none", forKey: "PreviousOperation")
            UserDefaults.standard.set(0.0 , forKey: "PreviousNumber")
        case Operations.equal.rawValue:
            //The last entered operation is performed and no operation is recorded in the memory
            operations(perviousNumber: UserDefaults.standard.double(forKey: "PreviousNumber"), accumulator: result, operation: UserDefaults.standard.string(forKey: "PreviousOperation")!)
            UserDefaults.standard.set("none", forKey: "PreviousOperation")
        case Operations.plus.rawValue:
            //The last entered operation is performed and the addition operation is stored in the memory.
            if UserDefaults.standard.string(forKey: "PreviousOperation") != "none"{
                operations(perviousNumber: UserDefaults.standard.double(forKey: "PreviousNumber"), accumulator: result, operation: UserDefaults.standard.string(forKey: "PreviousOperation")!)
                UserDefaults.standard.set("plus", forKey: "PreviousOperation")
                //If no transaction is stored in the memory, the addition operation is saved
            }else {
                UserDefaults.standard.set("plus", forKey: "PreviousOperation")
            }
        case Operations.minus.rawValue:
            //The last entered operation is performed and the minus operation is stored in the memory.
            if UserDefaults.standard.string(forKey: "PreviousOperation") != "none"{
                operations(perviousNumber: UserDefaults.standard.double(forKey: "PreviousNumber"), accumulator: result, operation: UserDefaults.standard.string(forKey: "PreviousOperation")!)
                UserDefaults.standard.set("minus", forKey: "PreviousOperation")
                //If no transaction is stored in the memory, the addition operation is saved
            }else {
                UserDefaults.standard.set("minus", forKey: "PreviousOperation")
            }
        case Operations.multiply.rawValue :
            if UserDefaults.standard.string(forKey: "PreviousOperation") != "none"{
                operations(perviousNumber: UserDefaults.standard.double(forKey: "PreviousNumber"), accumulator: result, operation: UserDefaults.standard.string(forKey: "PreviousOperation")!)
                UserDefaults.standard.set("multiply", forKey: "PreviousOperation")
            }else {
                UserDefaults.standard.set("multiply", forKey: "PreviousOperation")
            }
        case Operations.divide.rawValue :
            if UserDefaults.standard.string(forKey: "PreviousOperation") != "none"{
                operations(perviousNumber: UserDefaults.standard.double(forKey: "PreviousNumber"), accumulator: result, operation: UserDefaults.standard.string(forKey: "PreviousOperation")!)
                UserDefaults.standard.set("divide", forKey: "PreviousOperation")
            }else {
                UserDefaults.standard.set("divide", forKey: "PreviousOperation")
            }
        default:
            break
        }
    }
    
    func setOperand(_ value: Double) {
        accumulator = value
        if UserDefaults.standard.double(forKey: "PreviousNumber") != 0.0 {
        }else {
            UserDefaults.standard.set(value, forKey: "PreviousNumber")
        }
    }
    
    func operations(perviousNumber: Double , accumulator : Double , operation : String ){
        switch operation{
        case "plus" :
            //For serial operation, the result is stored in the memory and takes the previous number.
            self.accumulator  = perviousNumber + accumulator
            UserDefaults.standard.set(self.accumulator, forKey: "PreviousNumber")
        case "minus" :
            self.accumulator  = perviousNumber - accumulator
            UserDefaults.standard.set(self.accumulator, forKey: "PreviousNumber")
        case "multiply" :
            self.accumulator  = perviousNumber * accumulator
            UserDefaults.standard.set(self.accumulator, forKey: "PreviousNumber")
        case "divide" :
            self.accumulator  = perviousNumber / accumulator
            UserDefaults.standard.set(self.accumulator, forKey: "PreviousNumber")
        default : break
        }
    }
    
    enum Operations : String {
        case sqrt = "√"
        case percent = "%"
        case log = "log"
        case C = "C"
        case CE = "CE"
        case equal = "="
        case plus = "+"
        case minus = "-"
        case multiply = "x"
        case divide = "/"
    }
        
}
