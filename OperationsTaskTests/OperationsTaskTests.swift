//
//  OperationsTaskTests.swift
//  OperationsTaskTests
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import XCTest
@testable import OperationsTask

class OperationsTaskTests: XCTestCase {
    
    
    
    func testOperationInsertion() {
        let viewModel = OperationsVM()
        
        let i = 1500
        if var value = try? viewModel.operations.value() {
            
            for _ in 0..<i {
                value.append(OperationModel(operand1: 2, operand2: 3, currentOperator: .multiplication, delayTime: 1))
            }
           
            viewModel.operations.onNext(value)
        }else{
            XCTFail()
        }
        XCTAssertTrue(try viewModel.operations.value().count == i)
    }
    
    
    
    func testOperations() {
        let viewModel = OperationsVM()
        
        if var value = try? viewModel.operations.value() {

            value.append(OperationModel(operand1: 2, operand2: 3, currentOperator: .add, delayTime: 1))
            value.append(OperationModel(operand1: 5, operand2: 10, currentOperator: .division, delayTime: 1))
            value.append(OperationModel(operand1: 50, operand2: 60, currentOperator: .multiplication, delayTime: 1))
            value.append(OperationModel(operand1: 18, operand2: 27, currentOperator: .subsitution, delayTime: 1))

            viewModel.operations.onNext(value)
        }else{
            XCTFail()
        }
        try? viewModel.operations.value()[0].calculateResult()
        try? viewModel.operations.value()[1].calculateResult()
        try? viewModel.operations.value()[2].calculateResult()
        try? viewModel.operations.value()[3].calculateResult()
        XCTAssertTrue(try viewModel.operations.value().count == 4)
        XCTAssertEqual(try viewModel.operations.value()[0].getRestult(), "5")
        XCTAssertEqual(try viewModel.operations.value()[1].getRestult(), "0.5")
        XCTAssertEqual(try viewModel.operations.value()[2].getRestult(), "3000")
        XCTAssertEqual(try viewModel.operations.value()[3].getRestult(), "-9")
    }
    
    func testOperationsBulk() {
        let viewModel = OperationsVM()

        let i = 1000
        if var value = try? viewModel.operations.value() {
            
            for index in 0..<i {
                value.append(OperationModel(operand1: index+2, operand2: index+3, currentOperator: .multiplication, delayTime: 1))
                value[index].calculateResult()
                
                XCTAssertEqual(value[index].getRestult(), String((index+2)*(index+3)))

            }
           
            viewModel.operations.onNext(value)
        }else{
            XCTFail()
        }
        
    }
    
    
    
        
    func testPerformanceExample() throws {
        self.measure {
            testOperationInsertion()
            testOperations()
            testOperationsBulk()
        }
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
