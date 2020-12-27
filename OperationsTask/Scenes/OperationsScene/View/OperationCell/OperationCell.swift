//
//  OperationCell.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit
import RxSwift

class OperationCell: UITableViewCell {

    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    
    func configureCell(operation: OperationModel){
        operationLabel.text = operation.getOpearion()
        timeLabel.text = String(Int(operation.delayTime))
        resultLabel.text = operation.getRestult()
    }
    
}
