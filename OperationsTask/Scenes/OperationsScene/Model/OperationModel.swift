//
//  OperationModel.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import Foundation
import RxSwift

class OperationModel{
    
    var operand1: Int
    var operand2: Int
    var mathOperator: MathOperator
    var delayTime: TimeInterval
    var result = BehaviorSubject<String>(value: "Pending")
        
    init(operand1: Int, operand2: Int, currentOperator: MathOperator, delayTime: TimeInterval) {
        self.operand1 = operand1
        self.operand2 = operand2
        self.mathOperator = currentOperator
        self.delayTime = delayTime
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delayTime) {
            self.calculateResult()
            SoundHelper.shared.playOperationDone()

        }
    }
    
    func getOpearion() -> String{
        return String(operand1) + " \(mathOperator.rawValue) " + String(operand2)
    }
    
    func calculateResult(){
        switch mathOperator {
        case .add:
            result.onNext(String(operand1 + operand2))
        case .multiplication:
            result.onNext(String(operand1 * operand2))
        case .division:
            if operand2 == 0 {
                result.onNext("ERROR ")
            }else{
                //Check if result doesn't contains decimal display it as Integar
                //example if result = 0.5 it will display 0.5
                //if result = 14.0 it will display 14
                let operationResult = Double(operand1) / Double(operand2)
                if operationResult.isIntegar() {
                    result.onNext(String(Int(operationResult)))
                }else{
                    result.onNext(String(round(operationResult*100)/100))
                }
            }
        case .subsitution:
            result.onNext(String(operand1 - operand2))
        }
    }
 
    func getRestult() -> String{
        if let result = try? result.value(){
            return result
        }else{
            return "Pending"
        }
    }

}
