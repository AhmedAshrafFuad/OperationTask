//
//  Double + IsIntegar.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 27/12/2020.
//

import Foundation

extension Double{
    func isIntegar()->Bool{
        if floor(self) == self{
            return true
        }
        return false
    }
}
