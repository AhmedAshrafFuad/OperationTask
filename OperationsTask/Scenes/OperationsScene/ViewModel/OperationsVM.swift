//
//  OperationsVM.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import Foundation
import RxSwift

class OperationsVM {

    var operations: BehaviorSubject<[OperationModel]> = BehaviorSubject(value: [OperationModel]())

    let showResults = PublishSubject<Bool>()

    var operand1: String?
    var operand2: String?
    var oprator: MathOperator?
    var delayTime: TimeInterval = 1

    let errorOccured = PublishSubject<String>()
    let updatedTableHeight = PublishSubject<Int>()
    let reloadTableForResult = PublishSubject<Bool>()

    let disposeBag = DisposeBag()
    
    func equalClicked(){
        guard let operand1 = operand1, let operand2 = operand2 else {
            self.errorOccured.onNext("Please insert the operands")
            return
        }
        guard let oprator = oprator else {
            self.errorOccured.onNext("Please select operator")
            return
        }

        if var value = try? operations.value() {
            
            let newOperation = createOperation(operand1: Int(operand1) ?? 0,
                                              operand2: Int(operand2) ?? 0,
                                              currentOperator: oprator,
                                              delayTime: delayTime)
            value.insert(newOperation, at: 0)
            operations.on(.next(value))
            updatedTableHeight.onNext(value.count)
           
            if value.count == 1{
                showResults.onNext(true)
            }
        }else{
            self.errorOccured.onNext("Cannot access data model")
        }
    }
    
    func createOperation(operand1: Int,operand2: Int,currentOperator: MathOperator,delayTime: TimeInterval)->OperationModel{
        let newOperation = OperationModel(operand1: operand1,
                                          operand2: operand2,
                                          currentOperator: currentOperator,
                                          delayTime: delayTime)
        newOperation.result.subscribe(onNext: { (_) in
            DispatchQueue.main.async {
                self.reloadTableForResult.onNext(true)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        return newOperation
    }

    
    
}

