//
//  GradientLayer.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit

class GradientLayer: CAGradientLayer {
    
    var startColor:   UIColor = .black
    var endColor:     UIColor = .white
    var startLocation: Double =   0.05
    var endLocation:   Double =   0.95
    var horizontalMode:  Bool =  false
    var diagonalMode:    Bool =  false
    
    func viewDidLayoutSubViews(){
        updatePoints()
        updateLocations()
        updateColors()
    }
    
    func updatePoints() {
        if horizontalMode {
            startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        colors = [startColor.cgColor, endColor.cgColor]
    }
}
